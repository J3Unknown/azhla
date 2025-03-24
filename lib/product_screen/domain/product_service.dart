import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/home_screen/data/home_object.dart';
import 'package:azhlha/product_screen/data/product_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';

class ProductService{
  static Future<ProductDetails?> product(BuildContext context,int id,) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "api/product_details?id=$id"));

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
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        ProductDetails productDetails = ProductDetails.fromJson(bodyJson['result']);
        return productDetails;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
}