import 'dart:convert';
import 'package:dino_map/constants.dart';
import 'package:dino_map/my_location.dart';

import 'package:http/http.dart' as http;

// ignore: camel_case_types
class API_HELPER {
  static String sessionID = "D51C8585-C2F3-4424-A746-08044712D0A3";
  static Map<String, String> getHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Session-ID': sessionID
    };
  }

  static Future<List<MyLocation>> getLocations(
      String city, String district, String ward) async {
    final jobsListAPIUrl =
        SERVER_URL + '/dino/map?City=$city&District=$district&Ward=$ward';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new MyLocation.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
