import 'dart:convert';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/models/user.dart';

import '../constants/urls.dart';

import 'package:http/http.dart' as http;

class DataService {
  getUserInfo() async {
    var accessToken = await SessionManager().get("token");
    const userInfoApiURL = "${APIurls.devURL}users/me/";
    var client = http.Client();
    User? userInfo;
    try {
      var response = await client.get(
        Uri.parse(userInfoApiURL),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        userInfo = User.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return userInfo;
  }
}
