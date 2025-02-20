import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import '../Data/about_us_data.dart';

class AboutUsService{
  static Future<AboutUs?> aboutUSApi(BuildContext context) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "about_us"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    // log("token"+token);
    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      // 'Authorization': "Bearer " + token,
      'Accept':'application/json',
      'Lang':locale.languageCode
    });

    // Body
    // request.fields.addAll({
    //   "phone" : phone
    // });

    // Send
    StreamedResponse response = await request.send();
    log(response.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        // List<dynamic> basket = bodyJson['result'];
         AboutUs aboutUs =AboutUs.fromJson(bodyJson['result']);
        // for(int i = 0 ;i<bodyJson['result'].length;i++){
        //   basket.add( BasketObject.fromJson(bodyJson['result'][i]));
        // }
       // log("length Basket"+basket.length.toString());
        return aboutUs;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static void sendContactMessage(BuildContext context, String phone,String title, String message) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "contactUs"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    // Headers
    //Locale locale = await getLocale();
    var headers = {
      'Authorization': "Bearer " + token,
      //'Accept':'application/json',
      'Lang':'en',
    };

    request.headers.addAll(headers);
    int userId;

    //userId = prefs.getInt("user_id")!;
    request.fields.addAll({
      "phone" : phone,
      "description" : message,
      "name" : title
    });


    // Send
    StreamedResponse response = await request.send();
    log("Sent");
    log(request.fields.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {

        showToast(context, bodyJson['msg']);
      //  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => MapScreenNew(rideId: '', noti: false,)));
      }
    } else {
      log("errorss");
      showToastError(context,"We ran into problem");
      return null;
    }
  }

}