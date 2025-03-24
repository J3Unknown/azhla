import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/profile_screen/data/profile_object.dart';
import 'package:azhlha/sign_up_screen/data/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import 'package:http/http.dart';

class ProfileService{
  static Future<ProfileObject> profile() async{
    log("Get Full ad API");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    log(token);
    Locale locale = await getLocale();
    var headers = {
      'Authorization': "Bearer " + token,
      'Accept':'application/json',
      //'Accept-Language' : locale.languageCode
      // 'Accept-Language' : locale.languageCode
      'Lang':locale.languageCode
    };


    // URI
    Uri uri = Uri.parse(AppConstants.MAIN_URL + "api/profile");
    log(uri.toString());
    // Body
    var body = {
      //'user_id' : adId.toString(),
    };
    log('id');
    //log(adId.toString());
    // if(userId != null) body.addAll({'user_id' : userId.toString()});

    //Making the request => Get
    Response res = await get(
        uri,
        //  body: body,
        headers : headers
    ); // There is no body or encoding because this is get request
    if (res.statusCode == 200) {
      dynamic bodyJson = jsonDecode(res.body); // will be list
      var data = bodyJson['result'];
      log("data test ");
      log(data.toString());
      ProfileObject user = ProfileObject.fromJson(data) ;
      log("Got user Succefully");
      return user;
    } else {
      //log(res.body);
      throw "Unable to get ads.";
    }
  }
  static Future<String> editProfile(BuildContext context,String name,String phone, String password,String? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;

    // Uri
    log('strat');
    log('end');
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "api/edit_profile"));

    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({'Authorization': "Bearer " + token, 'Lang':locale.languageCode});

    request.fields.addAll(
      {
        'name':name,
        'phone':phone,
        'password':password
      }
    );
    if(image != null) {
      request.files.add(await MultipartFile.fromPath("image", image));
      log("edit image");
      log(MultipartFile.fromPath("image", image).toString());
    }


    StreamedResponse response = await request.send();
    log("Sent");
    log(request.url.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson.toString());

      if (bodyJson['success'] != false) {

        // showToast(context, bodyJson['msg']);
        var data = bodyJson['result'];
        log("data test ");
        log(data.toString());
        //ProfileObject user = ProfileObject.fromJson(data) ;
        //prefs.remove('image');
        //prefs.remove('name');

        //prefs.setString("name", user.name!);
        return bodyJson['msg'];
      } else {

        throw bodyJson['msg'];
      }
    } else {
      var body = await response.stream.bytesToString();
      // var bodyJson = jsonDecode(body);
      log("errorss");
      log(response.statusCode.toString());
      //log(bodyJson['msg']);
      showToast(context, "We ran into problem");
      //return null;
      throw 'unable to get data';
    }
  }
  static Future<bool?> deleteAccount(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;


    // URL
    Uri uri = Uri.parse(AppConstants.MAIN_URL + 'api/profile');

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
    Response res = await delete(uri, headers: headers); // There is no body or encoding because this is get request
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

      throw "Unable to retrieve ads.";
    }
  }

}