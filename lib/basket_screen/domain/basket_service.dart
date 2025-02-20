import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/basket_screen/data/basket_object.dart';
import 'package:azhlha/product_screen/data/product_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';

class BasketService{
  static Future<List<BasketObject>?> basket(BuildContext context) async {
    // Uri
    var request = MultipartRequest('GET', Uri.parse(AppConstants.MAIN_URL + "myBasket"));
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
        showToast(context, bodyJson['msg']);
        return null;
      } else {
        List<BasketObject> basket = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          basket.add( BasketObject.fromJson(bodyJson['result'][i]));
        }
        log("length Basket"+basket.length.toString());
        return basket;
      }
    } else {
      log("errorss f45");
      showToast(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> deleteFromBasket(BuildContext context,String id) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "cancelItem"));
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
        showToast(context, bodyJson['msg']);
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
      showToast(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> addToBasket(BuildContext context,String id,List<ExtraServicesRequest> extraServicesRequest) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "addToBasket"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    log("token"+token);
    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      'Authorization': "Bearer " + token,
      'Accept':'application/json',
      'Lang':locale.languageCode,
    });

    List<Map<String, dynamic>> extraServiceJsonList = extraServicesRequest.map((service) => service.toJson()).toList();
    String extraServiceJsonString = jsonEncode(extraServiceJsonList);

    // Body
    request.fields.addAll({
      "product_id" : id,
     // "extraService": extraServiceJsonString,
    });
    if(extraServicesRequest.isNotEmpty){
    for(int i =0 ;i<extraServicesRequest.length;i++)
      {
        request.fields.addAll({"extraService[$i][id]":extraServicesRequest[i].id.toString()});
      }
    }
    // Send
    StreamedResponse response = await request.send();
    log(response.request!.headers.toString());
    log(request.url.toString());
    log(response.statusCode!.toString());
    log(request.method);
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
        showToast(context, getTranslated(context, "Added to basket")!);
        return true;
      }
    } else {

      log("errorss f45");
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      //log(bodyJson);
      showToastError(context,"We ran into problem");
      return null;
    }
  }
}