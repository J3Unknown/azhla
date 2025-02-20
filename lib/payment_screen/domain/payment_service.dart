import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/payment_screen/presentation/sucess_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import '../presentation/payment_screen.dart';

class PaymentServcie{
  static Future<bool?> confirmOrder(BuildContext context,String address_id,String payment_type) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "add_order"));
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

    // List<Map<String, dynamic>> extraServiceJsonList = extraServicesRequest.map((service) => service.toJson()).toList();
    // String extraServiceJsonString = jsonEncode(extraServiceJsonList);

    // Body
    request.fields.addAll({
      "address_id" : address_id,
      "payment_type" : payment_type,
      // "extraService": extraServiceJsonString,
    });

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
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>SuccessScreen()));

        //showToast(context, bodyJson['msg']);
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
  static Future<double?> applyCopon(BuildContext context,String price,String code) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "check_availabilty"));
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

    // List<Map<String, dynamic>> extraServiceJsonList = extraServicesRequest.map((service) => service.toJson()).toList();
    // String extraServiceJsonString = jsonEncode(extraServiceJsonList);

    // Body
    request.fields.addAll({
      "code" : code,
      "price" : price,
      // "extraService": extraServiceJsonString,
    });

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
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>SuccessScreen()));

        //showToast(context, bodyJson['msg']);
        return double.parse(bodyJson['result'].toString());
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
  static Future<String?> getPaymentScreen(BuildContext context,String methodName,String orderId,String paymentOption) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "pay"));
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

    // List<Map<String, dynamic>> extraServiceJsonList = extraServicesRequest.map((service) => service.toJson()).toList();
    // String extraServiceJsonString = jsonEncode(extraServiceJsonList);

    // Body
    request.fields.addAll({
      "payment_method" : methodName,
      "payment_option":paymentOption,
      "order_id":orderId
      // "price" : price,
      // "extraService": extraServiceJsonString,
    });

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
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>SuccessScreen()));

        //showToast(context, bodyJson['msg']);
        return bodyJson['result']['payment_url'].toString();
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