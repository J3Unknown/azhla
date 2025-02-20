import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/sign_in_screen/data/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import 'package:http/http.dart';

class UserService{
  static Future<Login?> login(BuildContext context, String email,
      String password) async {
    log("LOGIN API");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log("data " + email+"  "+ password);
    Uri uri = Uri.parse(AppConstants.LOGIN);

    log("Headers");
    Locale locale = await getLocale();
    log("Got Locale");
    var headers = {
      'Accept':'application/json',
      'Lang':locale.languageCode
    };

    log("Body");
    log("Getting Device Token");
    String device_token = '';
    if (prefs.containsKey('device_token'))
      device_token = prefs.getString("device_token")!;
    if (prefs.containsKey('first_time')) log(prefs.getString("first_time")!);
    log(device_token);
    //Body
    var body = {
      "phone": email,
      "password": password,
      //'device_id':device_token,
      "device_id": "uffhjlggyut76765765ittfytf"
    };
    body.forEach((key, value) {
      log(value);
    });

    // Request => Post
    log("Sending");
    log(body.toString());
    log(uri.toString());
    log(headers.toString());
    Response res = await post(uri, body: body,
        headers: headers); // There is no body or encoding because this is get request
    log("Sent");

    if (res.statusCode == 200) {
      log("200");
      dynamic bodyJson = jsonDecode(
          res.body); // will be token and UserModel object
      log(bodyJson['success'].toString());
      if (bodyJson['success'] == false) {
        log("not");
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        log("yes");
        if (!bodyJson.containsKey("result")) return null;
        log("after");
        // The Whole Data
        var data = bodyJson['result'];
        // 1- Token
        // String? token = data['user']['token'];
        // log("token");
        // log(token.toString());
        // log(data.toString());
        // 2- Model
        Login user = Login.fromJson(data);
        //var ret = {"token": token, "user": user};
        log("Logged In Succeffully");
        return user;
      }
    } else {
      dynamic bodyJson = jsonDecode(res.body);
      log(bodyJson.toString());
      log('Error');
      throw "Unable to retrieve ads.";
    }
    return null;
  }
}