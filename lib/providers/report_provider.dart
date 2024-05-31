import 'package:flutter/material.dart';

class ReportProvider with ChangeNotifier {
  // definitions
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

  // seetters
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
}
