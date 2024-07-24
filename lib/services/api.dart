import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const apiUrl = "http://192.168.1.6:8080/api/";

class Api {
  Future<Response> post(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .post(Uri.parse(apiUrl + url), body: json.encode(body), headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer ${prefs.getString("token")}"
    });
    if (kDebugMode) {
      print("RESPONSE STATUSCODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
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

  Future<Response> postMultipart(String url, Map<String, dynamic> fields,
      {File? file, String? fileField}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl + url));

    // Adding fields
    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Adding file if provided
    if (file != null && fileField != null) {
      request.files
          .add(await http.MultipartFile.fromPath(fileField, file.path));
    }

    // Adding headers
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';

    // Sending the request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) {
      print("RESPONSE STATUSCODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }

    return response;
  }
}
