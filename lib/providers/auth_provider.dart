import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
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
  int? currentUserId;

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
      setAuthenticated(true);
      setLoading(false);
    } else {
      setLoading(true);
      setAuthenticated(false);
    }
    setLoading(true);
  }

  Future<List> register(Map userBody, BuildContext context) async {
    setLoading(true);
    final response = await api.post('register/account-info', userBody);
    if (response.statusCode == 201) {
      setAuthenticated(true);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // var decodedToken = json.decode(response.body)['token'];
      // prefs.setString('token', decodedToken);
      currentUserId = json.decode(response.body)['user_id'] as int;
      if (kDebugMode) {
        print("Current User Id: $currentUserId");
      }

      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        // print("Token: $decodedToken");
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

  Future<List> registerPersonalInfo(Map userBody, BuildContext context) async {
    setLoading(true);
    final response = await api.post('user/update/$currentUserId', userBody);

    try {
      var decodedResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        setAuthenticated(true);
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // Only attempt to retrieve the token if it exists in the response
        var decodedToken = decodedResponse['token'];
        if (decodedToken != null) {
          prefs.setString('token', decodedToken);
        }

        if (kDebugMode) {
          print("Response Status: ${response.statusCode}");
          print("Response Body: ${response.body}");
          print("Token: $decodedToken");
        }
        setLoading(false);
        return [true, ''];
      } else {
        setAuthenticated(false);
        // Handle errors based on response content
        var errorMessage =
            decodedResponse['errors'] ?? 'An unknown error occurred';
        if (kDebugMode) {
          print("Response Status: ${response.statusCode}");
          print("Response Body: ${response.body}");
        }
        setLoading(false);
        return [false, errorMessage];
      }
    } catch (e) {
      // Handle JSON parsing error
      if (kDebugMode) {
        print("JSON Parsing Error: $e");
      }
      setLoading(false);
      return [false, 'Error parsing response'];
    }
  }

  Future<List> login(Map userBody, BuildContext context) async {
    setLoading(true);
    final response =
        await api.post('http://192.168.1.10:8080/api/login', userBody);

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
