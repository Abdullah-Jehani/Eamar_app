import 'dart:convert';
import 'dart:io';
import 'package:eamar_app/services/api.dart';
import 'package:flutter/foundation.dart';
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
  bool isSuccessed = false;

  bool _isLocating = false;
  bool get isLocating => _isLocating;

  // Setters
  set selectedId(int? value) {
    _selectedReportId = value;
    if (kDebugMode) {
      print('Selected Report ID set to: $_selectedReportId');
    } // Debug print
    notifyListeners();
  }

  set selectedName(String? value) {
    selectedReportName = value;
    if (kDebugMode) {
      print('Selected Report Name set to: $selectedReportName');
    } // Debug print
    notifyListeners();
  }

  set selectedClassId(int? value) {
    selectedClassificationId = value;
    if (kDebugMode) {
      print('Selected Classification ID set to: $selectedClassificationId');
    } // Debug print
    notifyListeners();
    // Remove this fetch call since it's not needed here
    // if (value != null) {
    //   fetchSubClassifications(value);
    // }
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

    notifyListeners();
    if (kDebugMode) {
      print('All data cleared');
    }
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

          final id = (report['id'] as int?) ?? 0;
          final userId = (report['user_id'] as int?) ?? 0;
          final reportClassificationId =
              (report['report_classification_id'] as int?) ?? 0;
          final subClassificationId =
              (report['sub_classification_id'] as int?) ?? 0;

          final latitude =
              double.tryParse(report['latitude']?.toString() ?? '0.0') ?? 0.0;
          final longitude =
              double.tryParse(report['longitude']?.toString() ?? '0.0') ?? 0.0;

          final reportClassification =
              report['report_classification'] as Map<String, dynamic>?;
          final classificationName = reportClassification?['name'] ?? 'Unknown';

          final subClassification =
              report['sub_classification'] as Map<String, dynamic>?;
          final subClassificationName = subClassification?['name'] ?? 'Unknown';

          if (kDebugMode) {
            print(
                'Report ID: $id, Classification Name: $classificationName, Sub-Classification Name: $subClassificationName');
          }

          return {
            'id': id,
            'user_id': userId,
            'report_classification_id':
                reportClassificationId, // Correctly use the classification ID
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
            'classification_name':
                classificationName, // Add classification name to report data
            'sub_classification_name':
                subClassificationName, // Add sub-classification name to report data
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

      if (kDebugMode) {
        print('Fetching sub-classifications for parentId: $parentId');
      } // Debug print
      final response =
          await api.get('classifications/$parentId/subclassifications');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final subclassificationsData =
            body['subclassifications'] as List<dynamic>;

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
      _isLocating = false;
      notifyListeners();
    }
  }

  Future<bool> submitReport() async {
    final data = {
      'latitude': lat.toString(),
      'longitude': long.toString(),
      'location_name': location ?? '',
      'first_name': userName ?? '',
      'last_name': title ?? '',
      'phone_number': phoneNumber ?? '',
      'description': description ?? '',
      'report_classification_id': _selectedReportId?.toString() ?? '',
      'sub_classification_id': selectedClassificationId?.toString() ?? '',
    };

    try {
      var uri = Uri.parse('http://192.168.1.7:8080/api/reports');
      var request = http.MultipartRequest('POST', uri);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception('Token not found');
      }
      request.headers['Authorization'] = 'Bearer $token';

      data.forEach((key, value) {
        request.fields[key] = value;
        debugPrint('Adding field: $key = $value');
      });

      if (imagePath != null) {
        var imageFile = File(imagePath!);
        request.files.add(
            await http.MultipartFile.fromPath('report_image', imageFile.path));
        debugPrint('Adding image: ${imageFile.path}');
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        debugPrint('Submit Report Response: ${body['message']}');
        clearAllData();
        return true; // Successful submission
      } else {
        debugPrint('Failed to submit report: ${response.body}');
        return false; // Failed submission
      }
    } catch (e) {
      debugPrint('Error submitting report: $e');
      return false; // Error occurred
    }
  }

  Future<bool> deleteReport(int reportId) async {
    try {
      final uri = Uri.parse('http://192.168.1.7:8080/api/reports/$reportId');
      final response = await http.delete(uri, headers: await _getHeaders());

      if (kDebugMode) {
        print('Delete Report Status: ${response.statusCode}');
        print('Delete Report Body: ${response.body}');
      }

      if (response.statusCode == 200) {
        // Handle successful deletion
        _reports.removeWhere((report) => report['id'] == reportId);
        notifyListeners();
        return true;
      } else {
        throw Exception('حدث خطأ اثناء حذف التقرير');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting report: $e');
      }
      return false;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}
