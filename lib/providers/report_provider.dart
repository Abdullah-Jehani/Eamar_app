import 'dart:convert';
import 'dart:io';
import 'package:eamar_app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Api api = Api();

class ReportProvider with ChangeNotifier {
  // State Variables
  List<Map<String, dynamic>> _reports = [];
  List<Map<String, dynamic>> get reports => _reports;

  List<Map<String, dynamic>> _subClassifications = [];
  List<Map<String, dynamic>> get subClassifications => _subClassifications;

  int? _selectedReportId;
  int? get selectedReportId => _selectedReportId;

  String? selectedReportName;
  int? selectedClassificationId;
  double lat = 0.0;
  double long = 0.0;
  String? location;
  String? imagePath;
  String? userName;
  String? title;
  String? phoneNumber;
  String? description;

  bool _isLocating = false;
  bool get isLocating => _isLocating;

  // Setters
  set selectedId(int? value) {
    _selectedReportId = value;
    print('Selected Report ID set to: $_selectedReportId'); // Debug print
    notifyListeners();
  }

  set selectedName(String? value) {
    selectedReportName = value;
    print('Selected Report Name set to: $selectedReportName'); // Debug print
    notifyListeners();
  }

  set selectedClassId(int? value) {
    selectedClassificationId = value;
    print(
        'Selected Classification ID set to: $selectedClassificationId'); // Debug print
    notifyListeners();
    if (value != null) {
      // Fetch sub-classifications only if ID is not null
      fetchSubClassifications(value);
    }
  }

  void clearAllData() {
    _reports = [];
    _subClassifications = [];
    _selectedReportId = null;
    selectedReportName = null;
    selectedClassificationId = null;
    lat = 0.0;
    long = 0.0;
    location = null;
    imagePath = null;
    userName = null;
    title = null;
    phoneNumber = null;
    description = null;

    // Notify listeners after clearing data
    notifyListeners();
    print('All data cleared'); // Debug print
  }

 Future<void> fetchReports() async {
  try {
    final response = await api.get('user-reports');
    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final reportsData = body['reports'] as List<dynamic>;

      _reports = reportsData.map((item) {
        final report = item as Map<String, dynamic>;

        // Ensure integer fields are properly parsed
        final id = (report['id'] as int?) ?? 0;
        final userId = (report['user_id'] as int?) ?? 0;
        final _selectedReportId =
            (report['report_classification_id'] as int?) ?? 0;
        final subClassificationId =
            (report['sub_classification_id'] as int?) ?? 0;

        // Ensure latitude and longitude are properly parsed
        final latitude =
            double.tryParse(report['latitude']?.toString() ?? '0.0') ?? 0.0;
        final longitude =
            double.tryParse(report['longitude']?.toString() ?? '0.0') ?? 0.0;

        return {
          'id': id,
          'user_id': userId,
          'report_classification_id': _selectedReportId, // Correctly use the classification ID
          'sub_classification_id': subClassificationId,
          'report_image': report['report_image'] ?? '',
          'location_name': report['location_name'] ?? '',
          'latitude': latitude,
          'longitude': longitude,
          'description': report['description'] ?? '',
          'first_name': report['first_name'] ?? '',
          'last_name': report['last_name'] ?? '',
          'phone_number': report['phone_number'] ?? '',
          'status': report['status'] ?? '',
          'feedback': report['feedback'],
          'created_at': report['created_at'] ?? '',
          'updated_at': report['updated_at'] ?? '',
        };
      }).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load reports');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching reports: $e');
    }
  }
}


  Future<void> fetchSubClassifications(int parentId) async {
    try {
      _isLocating = true;
      notifyListeners();

      print(
          'Fetching sub-classifications for parentId: $parentId'); // Debug print
      final response =
          await api.get('classifications/$parentId/subclassifications');

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final subclassificationsData =
            body['subclassifications'] as List<dynamic>;

        if (kDebugMode) {
          print('Fetched Sub-Classifications: $subclassificationsData');
        }

        _subClassifications = subclassificationsData.map((item) {
          final subclassification = item as Map<String, dynamic>;
          return {
            'id': subclassification['id'] ?? 0,
            'name': subclassification['name'] ?? '',
            'image': subclassification['image'] ?? '',
          };
        }).toList();

        _isLocating = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load sub-classifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching sub-classifications: $e');
      }
      _isLocating = false;
      notifyListeners();
    }
  }

  Future<void> submitReport() async {
    final data = {
      'latitude': lat.toString(),
      'longitude': long.toString(),
      'location_name': location ?? '',
      'first_name': userName ?? '',
      'last_name': title ?? '',
      'phone_number': phoneNumber ?? '',
      'description': description ?? '',
      'report_classification_id': _selectedReportId?.toString() ?? '',
      'sub_classification_id': _subClassifications.isNotEmpty
          ? _subClassifications.first['id'].toString()
          : '',
    };

    print('Submitting Report with data: $data'); // Debug print

    try {
      var uri = Uri.parse('http://192.168.1.6:8080/api/reports');
      var request = http.MultipartRequest('POST', uri);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      request.headers['Authorization'] = 'Bearer $token';
      // Replace YOUR_ACCESS_TOKEN with the actual token

      // Add text fields to the request
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add image file to the request
      if (imagePath != null) {
        var imageFile = File(imagePath!);
        request.files.add(
            await http.MultipartFile.fromPath('report_image', imageFile.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        print('Submit Report Response: ${body['message']}');

        // Handle successful submission
        clearAllData(); // Clear data if needed
      } else {
        throw Exception('Failed to submit report');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting report: $e');
      }
    }
  }
}
