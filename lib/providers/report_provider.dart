import 'dart:convert';
import 'package:eamar_app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Api api = Api();

class ReportProvider with ChangeNotifier {
  // Definitions
  List<Map<String, dynamic>> _reports = [];
  List<Map<String, dynamic>> get reports => _reports;

  int? selectedReportId;
  String? selectedReportName;
  int? selectedClassificationId;
  double lat = 0.0;
  double long = 0.0;
  String? location;
  String? imagePath; // Variable to store the image path
  String? userName;
  String? title;
  String? phoneNumber;
  String? description;

  // Setters
  set selectedId(int? value) {
    selectedReportId = value;
    notifyListeners();
  }

  set selectedName(String? value) {
    selectedReportName = value;
    notifyListeners();
  }

  set selectedClassId(int? value) {
    selectedClassificationId = value;
    notifyListeners();
  }

  // Setter for imagePath
  set image(String? path) {
    imagePath = path;
    notifyListeners();
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
          final classificationId =
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
            'report_classification_id': classificationId,
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
}
