import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper(this.city);
  final String city;

  Future call_api() async {
    String url = "https://weatherapi-com.p.rapidapi.com/current.json?q=${city}";
    // Map querystring = {"q":"London","dt":"2022-12-25"};
    Map<String, String> headers = {
      "X-RapidAPI-Key": "c3962500aemsha871602ba023759p157541jsncf3d5858fbab",
      "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
    };
    var resp = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      return {'error': true};
    }
  }
}
