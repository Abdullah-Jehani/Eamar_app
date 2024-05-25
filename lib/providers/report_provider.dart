import 'package:flutter/material.dart';

class ReportProvider with ChangeNotifier {
  // definitions
  int? selectedReportId;
  int? selectedClassificationId;
  // seetters
  set selectedId(int? value) {
    selectedReportId = value;
    notifyListeners();
  }

  set selectedClassId(int? value) {
    selectedClassificationId = value;
    notifyListeners();
  }
}
