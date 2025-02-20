import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';

class SettingsService{
  static Future<bool?> logout(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;


    // URL
    Uri uri = Uri.parse(AppConstants.MAIN_URL + 'logout');

    // Headers
    Locale locale = await getLocale();
    var headers = {
      'Accept-Language' :locale.languageCode,
      'Authorization': "Bearer " + token,
    };

    //Body
    // No Body

    // Request => Post
    log("Sending");
    Response res = await get(uri, headers: headers); // There is no body or encoding because this is get request
    log("Sent");

    if (res.statusCode == 200) {
      log("200");

      dynamic bodyJson = jsonDecode(res.body); // will be token and UserModel object
      log(bodyJson.toString());
      if(bodyJson['success'] == false){
        showToastError(context, bodyJson['msg']);
        return null;
      } else{
        log("Signed Out Succeffully");
        return true;
      }
    } else {
      log('Error');
      //dynamic bodyJson = jsonDecode(res.body);
      log(res.body.toString());
      log(res.statusCode.toString());

      throw "Unable to retrieve ads.";
    }
  }
}