import 'dart:convert';
import 'dart:developer';

import 'package:azhlha/events_screen/data/MyEventsDTO.dart';
import 'package:azhlha/events_screen/data/events_details_object.dart';
import 'package:azhlha/events_screen/data/events_object.dart';
import 'package:azhlha/events_screen/data/famillies_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import '../data/EventReminderObject.dart';

class EventsService{
  static Future<List<EventsObject>?> getEvents(BuildContext context) async {
    // Uri
    var request = MultipartRequest('GET', Uri.parse(AppConstants.MAIN_URL + "api/event_categories"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    // log("token"+token);
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
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        List<EventsObject> events = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          events.add( EventsObject.fromJson(bodyJson['result'][i]));
        }
        log("length cities"+events.length.toString());
        return events;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }

  static Future<List<EventsObject>?> getMainEventsCategories(BuildContext context) async {
    // Uri
    var request = MultipartRequest('GET', Uri.parse("${AppConstants.MAIN_URL}api/main_categories"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("token")!;
    // log("token"+token);
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
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        List<EventsObject> events = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          events.add( EventsObject.fromJson(bodyJson['result'][i]));
        }
        log("length cities"+events.length.toString());
        return events;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }

  static Future<List<EventsDetailsObject>?> getEventsDetails(BuildContext context,int? event_category_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '';
    if(prefs.containsKey("selectedCity")){
      url+="&area_id=${(prefs.getInt("selectedCity"))}";
    }
    if(prefs.containsKey("selectedFamily")){
      url+="&family_name=${(prefs.getString("selectedFamily"))}";
    }
    if(prefs.containsKey("selectedValue")){
      url+="&gender=${(prefs.getString("selectedValue"))}";
    }
    if(prefs.containsKey("dateSelected")){
      url+="&date=${(prefs.getString("dateSelected"))}";
    }
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "api/events?event_category_id=${event_category_id}"+url));
    // String token = prefs.getString("token")!;
    // log("token"+token);
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
    log(request.url.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        List<EventsDetailsObject> events = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          events.add( EventsDetailsObject.fromJson(bodyJson['result'][i]));
        }
        log("length cities"+events.length.toString());
        if(prefs.containsKey("selectedCity")){
         prefs.remove("selectedCity");
        }
        if(prefs.containsKey("selectedFamily")){
          prefs.remove("selectedFamily");
        }
        if(prefs.containsKey("selectedValue")){
          prefs.remove("selectedValue");
        }
        if(prefs.containsKey("dateSelected")){
          prefs.remove("dateSelected");
        }
        return events;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<List<EventsDetailsObject>?> getAllEventsDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '';
    if(prefs.containsKey("selectedCity")){
      url+="area_id=${(prefs.getInt("selectedCity"))}";
    }
    if(prefs.containsKey("selectedFamily")){
      if(!prefs.containsKey("selectedCity")){
        url+="family_name=${(prefs.getString("selectedFamily"))}";
      }
      else{
        url+="&family_name=${(prefs.getString("selectedFamily"))}";
      }
    }
    if(prefs.containsKey("selectedValue")){
      if(!prefs.containsKey("selectedCity")&&!prefs.containsKey("selectedFamily")){
        url+="gender=${(prefs.getString("selectedValue"))}";
      }
      else{
        url+="&gender=${(prefs.getString("selectedValue"))}";
      }
    }
    if(prefs.containsKey("dateSelected")){
      if(!prefs.containsKey("selectedCity")&&!prefs.containsKey("selectedFamily")&&!prefs.containsKey("selectedValue")){
        url+="date=${(prefs.getString("dateSelected"))}";
      }
      else{
        url+="&date=${(prefs.getString("dateSelected"))}";

      }
    }
    // Uri
    var request = MultipartRequest('GET', Uri.parse( (url.isEmpty)?(AppConstants.MAIN_URL +"api/events"):AppConstants.MAIN_URL +"api/events?"+url));
    // String token = prefs.getString("token")!;
    // log("token"+token);
    // // Headers
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
    log(request.url.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        List<EventsDetailsObject> events = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          events.add( EventsDetailsObject.fromJson(bodyJson['result'][i]));
        }
        log("length cities"+events.length.toString());
        if(prefs.containsKey("selectedCity")){
          prefs.remove("selectedCity");
        }
        if(prefs.containsKey("selectedFamily")){
          prefs.remove("selectedFamily");
        }
        if(prefs.containsKey("selectedValue")){
          prefs.remove("selectedValue");
        }
        if(prefs.containsKey("dateSelected")){
          prefs.remove("dateSelected");
        }
        return events;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }

  static Future<List<FamiliesObject>?> getFamilies(BuildContext context) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "api/families"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      log(bodyJson['result'].toString());
      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        List<FamiliesObject> families = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          families.add( FamiliesObject.fromJson(bodyJson['result'][i]));
        }
        log("length cities"+families.length.toString());
        return families;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> addReminder(BuildContext context,String id) async {
    // Uri
    var request = MultipartRequest('POST', Uri.parse(AppConstants.MAIN_URL + "api/user_daily_events"));
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
    request.fields.addAll({
      "daily_event_id" : id
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
        log("false");
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        log("true add");
        // List<BasketObject> basket = [];
        // for(int i = 0 ;i<bodyJson['result'].length;i++){
        //   basket.add( BasketObject.fromJson(bodyJson['result'][i]));
        // }
        // log("length Basket"+basket.length.toString());
        showToastReminder(context, bodyJson['msg']);
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
  static Future<bool?> deleteReminder(BuildContext context,String id) async {
    // Uri
    var request = MultipartRequest('DELETE', Uri.parse(AppConstants.MAIN_URL + "api/user_daily_events?user_daily_event_id=$id"));
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
    // request.fields.addAll({
    //   "daily_event_id" : id
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

        showToastReminder(context, bodyJson['msg']);
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
  static Future<List<EventReminderObject>?> getEventReminders(BuildContext context) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "api/user_daily_events"));
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
        List<EventReminderObject> events = [];
        for(int i = 0 ;i<bodyJson['result'].length;i++){
          events.add( EventReminderObject.fromJson(bodyJson['result'][i]));
        }
        log("length cities"+events.length.toString());
        return events;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }

  static Future<bool?> deleteEvent(BuildContext context,String id) async {
    // Uri
    var request = MultipartRequest(
        'DELETE', Uri.parse(AppConstants.MAIN_URL + "api/daily_event?daily_event_id=$id"));
    log(id.toString());
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
    // request.fields.addAll({
    //   "id" : id
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
        log("deleted");
        log(request.url.toString());
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

  static Future<bool?> addEvent
      (BuildContext context,
      String imgPath,
      String title,
      String category,
      String familyName,
      String area,
      String date,
      String time,
      String description,
      String mWhatsapp,
      String fWhatsapp,
      String mPhone,
      String fPhone,
      String mAddress,
      String fAddress,
      String mLong,
      String fLong,
      String mLat,
      String fLat,
      String type
      ) async {
    // Uri
    var request = MultipartRequest('POST', Uri.parse(AppConstants.MAIN_URL + "api/add_daily_events"));
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
        "event_category_id" : category,
        "city_id":area,
        "type":type,
        "family_name":familyName,
        "f_phone":fPhone,
        "f_whatsApp_number":fWhatsapp,
        "f_address":fAddress,
        "f_latitude":fLat,
        "f_longitude":fLong,
        "whatsApp_number":mWhatsapp,
        "phone":mPhone,
        "address":mAddress,
        "latitude":mLat,
        "longitude":mLong,
        "date":date,
        "time":time,
        "description_ar":description,
        "description_en":description,
        "name_ar":title,
        "name_en":title,
    });
    request.files.add(await MultipartFile.fromPath("image", imgPath));

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
      //var bodyJson = jsonDecode(body);
      //log(bodyJson);
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<bool?> editEvent
      (BuildContext context,
      String id,
      String imgPath,
      String title,
      String category,
      String familyName,
      String area,
      String date,
      String time,
      String description,
      String mWhatsapp,
      String fWhatsapp,
      String mPhone,
      String fPhone,
      String mAddress,
      String fAddress,
      String mLong,
      String fLong,
      String mLat,
      String fLat,
      String type
      ) async {
    // Uri
    var request = MultipartRequest(
        'POST', Uri.parse(AppConstants.MAIN_URL + "api/edit_daily_events"));
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
      "id":id.toString(),
      "event_category_id" : category,
      "city_id":area,
      "type":type,
      "family_name":familyName,
      "f_phone":fPhone,
      "f_whatsApp_number":fWhatsapp,
      "f_address":fAddress,
      "f_latitude":fLat,
      "f_longitude":fLong,
      "whatsApp_number":mWhatsapp,
      "phone":mPhone,
      "address":mAddress,
      "latitude":mLat,
      "longitude":mLong,
      "date":date,
      "time":time,
      "description_ar":description,
      "description_en":description,
      "name_ar":title,
      "name_en":title,
    });
    if(!imgPath.startsWith("http") ||!imgPath.startsWith("https")) {
      request.files.add(await MultipartFile.fromPath("image", imgPath));
    }
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
        showToastAddEvent(context,"Updated");
        return true;
      }
    } else {

      log("errorss f45");
      var body = await response.stream.bytesToString();
      //var bodyJson = jsonDecode(body);
      //log(bodyJson);
      showToastError(context,"We ran into problem");
      return null;
    }
  }
  static Future<MyEventsDTO?> getMyEvents(BuildContext context) async {
    // Uri
    var request = MultipartRequest(
        'GET', Uri.parse(AppConstants.MAIN_URL + "api/user_events"));
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
        MyEventsDTO myEventsDTO = MyEventsDTO.fromJson(bodyJson['result']);
        // log("length cities"+favoriteProducts.length.toString());
        return myEventsDTO;
      }
    } else {
      log("errorss f45");
      showToastError(context,"We ran into problem");
      return null;
    }
  }

}