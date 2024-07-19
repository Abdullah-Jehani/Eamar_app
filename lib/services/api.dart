import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const apiUrl = "http://192.168.1.15:8080/api/";

class Api {
  Future<Response> post(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse(apiUrl + url), body: json.encode(body), headers: {
      "Accept": "Application/json",
      "content-type": "Application/json",
      "Authorization": "Bearer ${prefs.getString("token")}"
    });
    if (kDebugMode) {
      print("RESPONSE STATUSCODE : ${response.statusCode}");
      print("RESPONSE BODEY : ${response.body}");
    }

    return response;
  }

  Future<Response> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(apiUrl + url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${prefs.getString("token")}"
    });
    return response;
  }

  Future<Response> put(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(apiUrl + url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${prefs.getString("token")}"
    });
    return response;
  }

  Future<Response> delete(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.delete(Uri.parse(apiUrl + url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${prefs.getString("token")}"
    });
    return response;
  }
}
