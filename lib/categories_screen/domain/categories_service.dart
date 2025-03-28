import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';

class CategoriesService{
  static Future<bool?> AddSellerFav(BuildContext context,String id) async {
    // Uri
    var request = MultipartRequest('POST', Uri.parse(AppConstants.MAIN_URL + "api/favourite_sellers"));
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
    // Body
    request.fields.addAll({
      "id" : id
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
        showToast(context, bodyJson['msg']);
        return true;
      }
    } else {

      log("errorss f45");
      var body = await response.stream.bytesToString();
      //var bodyJson = jsonDecode(body);
     // log(bodyJson);
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> DeleteSellerFav(BuildContext context,String id) async {
    // Uri
    var request = MultipartRequest(
        'DELETE', Uri.parse(AppConstants.MAIN_URL + "api/favourite_sellers?favourite_id=$id"));
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
    log(id.toString());
    log(request.method);
    log(request.url.toString());
    // Body
    // request.fields.addAll({
    //   "" : id.toString()
    // });

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
        showToast(context, bodyJson['msg']);
        return true;
      }
    } else {

      log("errorss f45");
      var body = await response.stream.bytesToString();
      //var bodyJson = jsonDecode(body);
      // log(bodyJson);
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<List<dynamic>?> basket(BuildContext context) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "api/myFavourite_sellers"));
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
        List<dynamic> basket = bodyJson['result'];
        // for(int i = 0 ;i<bodyJson['result'].length;i++){
        //   basket.add( BasketObject.fromJson(bodyJson['result'][i]));
        // }
        log("length Basket"+basket.length.toString());
        return basket;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }


}