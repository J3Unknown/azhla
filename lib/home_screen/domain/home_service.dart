import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/home_screen/data/home_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';

class HomeService{
  static Future<HomeObject?> home(BuildContext context,String? category_id,String? govId) async {
    var request;
    if(category_id == null || govId == null){
      if(category_id != null){
       request = MultipartRequest('GET', Uri.parse(AppConstants.MAIN_URL + "api/categories?category_id=$category_id"));
      }
      if(govId != null){
        request = MultipartRequest('GET', Uri.parse(AppConstants.MAIN_URL + "api/categories?govId=$govId"));
      }
      if(category_id == null && govId == null){
        request = MultipartRequest('GET', Uri.parse(AppConstants.MAIN_URL + "api/categories"));
      }
    }
    else{
      request = MultipartRequest('GET', Uri.parse(AppConstants.MAIN_URL + "api/categories?category_id=$category_id&govId=$govId"));
    }
    // Uri


    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
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
    log("Request URL"+request.url.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        HomeObject homeObject = HomeObject.fromJson(bodyJson['result']);
        return homeObject;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
}