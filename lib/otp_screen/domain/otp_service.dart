import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import '../data/OTPObject.dart';

class OtpService{
  static Future<OTPObject?> sendOTP(BuildContext context, String phone) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "api/send_otp_register"));

    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      'Accept':'application/json',
      'Lang':locale.languageCode
    });

    // Body
    request.fields.addAll({
      "phone" : phone
    });

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
        OTPObject otpObject = OTPObject.fromJson(bodyJson['result']);

        return otpObject;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<OTPObject?> sendOTPPassword(BuildContext context, String phone) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "api/send_otp_password"));
    log("phoneController.text "+phone);

    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      'Accept':'application/json',
      'Lang':locale.languageCode
    });

    log("phone : "+phone);
    // Body
    request.fields.addAll({
      "phone" : phone
    });

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
        OTPObject otpObject = OTPObject.fromJson(bodyJson['result']);

        return otpObject;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }

}