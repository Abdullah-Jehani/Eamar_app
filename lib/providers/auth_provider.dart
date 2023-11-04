import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool isFirstTime = false;
  bool? isAuthenticated;
  bool? isLoading;
  String? token;

  setLoading(bool value) {
    Timer(const Duration(milliseconds: 5), () {
      isLoading = value;
      notifyListeners();
    });
  }

  setAuthenticated(bool value) {
    Timer(const Duration(milliseconds: 5), () {
      isAuthenticated = value;
      notifyListeners();
    });
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('isFirstTime') ?? true;
    notifyListeners();
  }

  Future<void> setFirstTime(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', value);
    isFirstTime = value;
    notifyListeners();
  }

  initAuthentication() async {
    setLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    if (token != null) {
      setLoading(false);
      setAuthenticated(true);
    } else {
      setLoading(true);
      setAuthenticated(false);
    }
    setLoading(true);
  }
}
