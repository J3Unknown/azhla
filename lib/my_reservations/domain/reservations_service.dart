import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/basket_screen/data/basket_object.dart';
import 'package:azhlha/my_reservations/data/reservations_object.dart';
import 'package:azhlha/product_screen/data/product_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';

class ReservationService{
  static Future<List<ReservationsObject>?> reservations(BuildContext context) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "myOrders"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    log("token"+token);
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
        List<ReservationsObject> reservations = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          reservations.add( ReservationsObject.fromJson(bodyJson['result'][i]));
        }
        log("length Basket"+reservations.length.toString());
        return reservations;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> cancelOrders(BuildContext context,String id,String reason) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "cancel_order"));
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

    log(reason);
    // Body
    request.fields.addAll({
      "id" : id,
      "reason":reason
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

      log("errorss f45");
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson);
      showToastError(context,"We ran into problem");
      return null;
    }
  }
}