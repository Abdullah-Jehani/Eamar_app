import 'dart:async';
import 'dart:convert';
import 'package:eamar_app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Api api = Api();
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

// check if user is authenticated or not.
  initAuthentication() async {
    setLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    if (kDebugMode) {
      print(" Token Status : $token");
      print(" isFirstTime ? : $isFirstTime");
    }
    if (token != null) {
      setLoading(false);
      setAuthenticated(true);
    } else {
      setLoading(true);
      setAuthenticated(false);
    }
    setLoading(true);
  }

  Future<List> register(Map userBody, BuildContext context) async {
    setLoading(true);
    final response =
        await api.post('http://192.168.1.112:8080/api/register', userBody);
    if (response.statusCode == 201) {
      setAuthenticated(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString('token', decodedToken);
      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Token: $decodedToken");
      }
      if (kDebugMode) {
        print("Response Body: ${response.body}");
      }
      return [true, ''];
    } else {
      setAuthenticated(false);
      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Response Body: ${response.body}");
      }
      setLoading(false);
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> login(Map userBody, BuildContext context) async {
    setLoading(true);
    final response =
        await api.post('http://192.168.1.112:8080/api/login', userBody);

    if (response.statusCode == 200) {
      setAuthenticated(true);
      setLoading(false);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString("token", decodedToken);
      if (kDebugMode) {
        print(" Response Status${response.statusCode}");
        print(" isFirstTime ? : $isFirstTime");
        print(" Token Status : $token");
        print(" Token : $decodedToken");
      }
      if (kDebugMode) {
        print(" Response Body ${response.body}");
        print(" isFirstTime ? : $isFirstTime");
      }
      setLoading(false);
      return [true, ''];
    } else {
      setAuthenticated(false);
      if (kDebugMode) {
        print(" Response Status${response.statusCode}");
      }
      if (kDebugMode) {
        print(" Response Body ${response.body}");
      }
      setLoading(false);
      return [false, json.decode(response.body)['message']];
    }
  }
}
