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
  int? currentUserId;
  String? currentUserName;
  String? currentEmail;
  String? phoneNumber;
  String? address;
  String? dob;
  String? profilePhoto;

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

  // Save user data to SharedPreferences
  Future<void> saveUserData(Map<String, dynamic> user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentUserId', user['id'] ?? 0);
    await prefs.setString('currentUserName', user['username'] ?? '');
    await prefs.setString('currentEmail', user['email'] ?? '');
    await prefs.setString('phoneNumber', user['phone'] ?? '');
    await prefs.setString('address', user['address'] ?? '');
    await prefs.setString('dob', user['dob'] ?? '');
    await prefs.setString('profilePhoto', user['profile_photo'] ?? '');
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getInt('currentUserId');
    currentUserName = prefs.getString('currentUserName');
    currentEmail = prefs.getString('currentEmail');
    phoneNumber = prefs.getString('phoneNumber');
    address = prefs.getString('address');
    dob = prefs.getString('dob');
    profilePhoto = prefs.getString('profilePhoto');
    if (kDebugMode) {
      print(
          "Loaded user data: $currentUserName, $currentEmail, $phoneNumber, $address , $profilePhoto");
    }
    notifyListeners();
  }

  // Check if user is authenticated or not
  Future<void> initAuthentication() async {
    setLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    await loadUserData(); // Load user data
    if (kDebugMode) {
      print("Token Status: $token");
      print("isFirstTime? : $isFirstTime");
    }
    if (token != null) {
      setAuthenticated(true);
    } else {
      setAuthenticated(false);
    }
    setLoading(false);
  }

  Future<List> register(
      Map<String, dynamic> userBody, BuildContext context) async {
    setLoading(true);
    final response = await api.post('register/account-info', userBody);
    if (response.statusCode == 201) {
      var decodedResponse = json.decode(response.body);
      setAuthenticated(true);
      await saveUserData(decodedResponse); // Save user data
      currentUserId = decodedResponse['user_id'];

      if (kDebugMode) {
        print("Decoded Response: $decodedResponse");
        print("Current User Id: $currentUserId");
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
      setLoading(false);
      return [true, ''];
    } else {
      setAuthenticated(false);
      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
      setLoading(false);
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> registerPersonalInfo(
      Map<String, dynamic> userBody, BuildContext context) async {
    setLoading(true);
    try {
      final response = await api.postMultipart(
        'user/update/$currentUserId',
        {
          "phone": userBody["phone"],
          "address": userBody["address"],
          "dob": userBody["dob"]
        },
        file: userBody["profile_photo"],
        fileField: "profile_photo",
      );

      var decodedResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        currentUserId = decodedResponse['user']['id'] ?? currentUserId;
        currentUserName =
            decodedResponse['user']['username'] ?? currentUserName;
        currentEmail = decodedResponse['user']['email'] ?? currentEmail;
        phoneNumber = decodedResponse['user']['phone'] ?? phoneNumber;
        address = decodedResponse['user']['address'] ?? address;
        dob = decodedResponse['user']['dob'] ?? dob;
        profilePhoto = decodedResponse['user']['profile_photo'] ?? profilePhoto;
        await saveUserData(decodedResponse['user']); // Save user data

        if (kDebugMode) {
          print("Current User Id: $currentUserId");
          print("Current User Name: $currentUserName");
          print("Current Email: $currentEmail");
          print("Current Phone: $phoneNumber");
          print("Current Address: $address");
          print("Current DOB: $dob");
          print("Current Profile Photo: $profilePhoto");
        }
        setAuthenticated(true);

        var decodedToken = decodedResponse['token'];
        if (decodedToken != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
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
      if (kDebugMode) {
        print("Unexpected Error: $e");
      }
      setLoading(false);
      return [false, 'حدث خطأ اثناء التسجيل'];
    }
  }

  Future<List> login(
      Map<String, dynamic> userBody, BuildContext context) async {
    setLoading(true);
    final response = await api.post('login/user', userBody);
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);

      currentUserId = decodedResponse['user']['id'] ?? currentUserId;
      currentUserName = decodedResponse['user']['username'] ?? currentUserName;
      currentEmail = decodedResponse['user']['email'] ?? currentEmail;
      phoneNumber = decodedResponse['user']['phone'] ?? phoneNumber;
      address = decodedResponse['user']['address'] ?? address;
      dob = decodedResponse['user']['dob'] ?? dob;
      profilePhoto = decodedResponse['user']['profile_photo'] ?? profilePhoto;

      await saveUserData(decodedResponse['user']); // Save user data
      setAuthenticated(true);
      setLoading(false);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = decodedResponse['token'];
      prefs.setString("token", decodedToken);

      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("isFirstTime? : $isFirstTime");
        print("Token Status: $token");
        print("Token: $decodedToken");
        print("Response Body: ${response.body}");
      }

      setLoading(false);
      return [true, ''];
    } else {
      setAuthenticated(false);
      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
      setLoading(false);
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<void> logout() async {
    setLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    if (kDebugMode) {
      print("Token Status: $token");
    }
    if (token != null) {
      final response = await api.post('logout', {});
      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
      if (response.statusCode == 200) {
        await prefs.remove('token');
        await prefs.remove('currentUserId');
        await prefs.remove('currentUserName');
        await prefs.remove('currentEmail');
        await prefs.remove('phoneNumber');
        await prefs.remove('address');
        await prefs.remove('dob');
        await prefs.remove('profilePhoto');
        setAuthenticated(false);
      }
    }
    setLoading(false);
  }

  Future<List> updateUserData({
    required String username,
    required String email,
    required String address,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    setLoading(true);

    // Prepare user data
    final userBody = {
      'username': username,
      'email': email,
      'phone': phoneNumber,
      'address': address,
    };

    try {
      final response = await api.post('user', userBody);

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (kDebugMode) {
          print('API Response: $decodedResponse');
        } // Debug logging

        // Check if 'user' is present and not null
        if (decodedResponse['user'] != null) {
          // Update local user data
          currentUserName =
              decodedResponse['user']['username'] ?? currentUserName;
          currentEmail = decodedResponse['user']['email'] ?? currentEmail;
          phoneNumber = decodedResponse['user']['phone'] ?? phoneNumber;
          address = decodedResponse['user']['address'] ?? address;

          await saveUserData(decodedResponse['user']); // Save updated user data

          setLoading(false);
          return [true, ''];
        } else {
          setLoading(false);
          return [false, 'بيانات غير صحيحة'];
        }
      } else {
        var errorMessage = json.decode(response.body)['message'] ??
            'حدث خطأ الرجاء التحقق من اتصالك بالانترنت';
        setLoading(false);
        return [false, errorMessage];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      } // Debug logging
      setLoading(false);
      return [false, 'حدث خطأ الرجاء التحقق من اتصالك بالانترنت'];
    }
  }
}
