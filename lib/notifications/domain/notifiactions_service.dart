import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/notifications/Data/notifications_dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';

class NotificationsService{
  static Future<List<NotificationsDTO>?> getAllNotifications(BuildContext context) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "notifications"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      'Authorization': "Bearer " + token,
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
        List<NotificationsDTO> notifications = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          notifications.add( NotificationsDTO.fromJson(bodyJson['result'][i]));
        }

        return notifications;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> markAsRead(BuildContext context,String id) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "read_notification"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    log("token"+token);
    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      'Authorization': "Bearer " + token,
      //'Accept':'application/json',
      'Lang':locale.languageCode
    });

    // log(reason);
    // Body
    request.fields.addAll({
      "id" : id,
      // "reason":reason
    });

    // Send
    StreamedResponse response = await request.send();
    log(response.request!.headers.toString());
    log(response.statusCode.toString());
    log(request.fields.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        // List<BasketObject> basket = [];
        // for(int i = 0 ;i<bodyJson['result'].length;i++){
        //   basket.add( BasketObject.fromJson(bodyJson['result'][i]));
        // }
        // log("length Basket"+basket.length.toString());
        return true;
      }
    } else {

      var body = await response.stream.bytesToString();
      try {
        // Try to parse error response into JSON and log the error message
        var errorJson = jsonDecode(body);
        if (errorJson.containsKey('msg')) {
          log("Error Message: ${errorJson['msg']}");
          showToastError(context, errorJson['msg']);
        } else {
          log("Error: ${body}");
          showToastError(context, "An unexpected error occurred.");
        }
      } catch (e) {
        // Fallback if response is not JSON
        log("Error Response: ${body}");
        showToastError(context, "We ran into a problem.");
      }
      return null;
    }
  }
}