import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import '../data/cities_object.dart';

class AddressService{
  static Future<List<CitiesObject>?> getCities(BuildContext context) async {
    // Uri
    var request = MultipartRequest('GET', Uri.parse("${AppConstants.MAIN_URL}api/cities"));
    //SharedPreferences prefs = await SharedPreferences.getInstance();
   // String token = prefs.getString("token")!;
    //log("token"+token);
    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      //'Authorization': "Bearer " + token,
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
      log(bodyJson['result'].length.toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        List<CitiesObject> cities = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          cities.add( CitiesObject.fromJson(bodyJson['result'][i]));
          log(bodyJson['result'][i]);
        }
        return cities;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<List<CitiesObject>?> getRegions(BuildContext context,) async {
    // Uri
    var request = MultipartRequest('GET', Uri.parse("${AppConstants.MAIN_URL}api/regions"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    log('${AppConstants.MAIN_URL}regions');
    // Headers
    Locale locale = await getLocale();
    request.headers.addAll({
      //'Authorization': "Bearer " + token,
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
      log(bodyJson['result'].length.toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        List<CitiesObject> cities = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          cities.add( CitiesObject.fromJson(bodyJson['result'][i]));
          log(cities[i].name!);
        }
        return cities;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> addAdrees(BuildContext context,String id,String floor_no,String street,String block_no,String building_no,String notes) async {
    // Uri
    var request = MultipartRequest('POST', Uri.parse("${AppConstants.MAIN_URL}api/add_client_region"));
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

    // Body
    request.fields.addAll({
      "id" : id,
      "street":street,
      "block_no":block_no,
      "building_no":building_no,
      "floor_no":floor_no,
      "notes":notes
      // "extraService": extraServiceJsonString,
    });

    // Send
    StreamedResponse response = await request.send();
    log(response.request!.headers.toString());
    log(request.url.toString());
    log(response.statusCode.toString());
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
        showToast(context, bodyJson['msg']);
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