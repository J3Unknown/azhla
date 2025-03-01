import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:azhlha/shared/alerts.dart';
import 'package:azhlha/special_request/data/requests_list_model.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utill/localization_helper.dart';

class SpecialRequestListServices {
  static Future<RequestsListModel?> getRequestsList(context) async {
    var request = MultipartRequest('GET', Uri.parse(AppConstants.SPECIAL_REQUEST));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(AppConstants.SPECIAL_REQUEST);
    Locale locale = await getLocale();

    String token = '';
    if (prefs.containsKey(AppConstants.TOKEN)) {
      token = prefs.getString(AppConstants.TOKEN)!;
    }
    log(token);

    request.headers.addAll({
     'Accept':'application/json',
      AppConstants.AUTORIZATION:'Bearer $token',
      'Lang':locale.languageCode
    });

    StreamedResponse response = await request.send();

    if(response.statusCode == 200){
      var body = await response.stream.bytesToString();
      log(response.statusCode.toString());
      log(body.toString());
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());

      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        RequestsListModel requestsListModel;
        requestsListModel = RequestsListModel.fromJson(bodyJson);
        return requestsListModel;
      }
    }else{
      showToastError(context, 'we ran into a problem');
      log(response.statusCode.toString());
      return null;
    }
  }

  static Future<bool?> sendSpecialRequest(context, {required int categoryId, required int areaId, required String familyName, required int budget, required String date, required String time, required String description,}) async {
    var request = MultipartRequest('POST', Uri.parse(AppConstants.ADD_SPECIAL_REQUEST));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    Locale locale = await getLocale();
    request.headers.addAll({
      'Authorization': "Bearer $token",
      'Accept':'application/json',
      'Lang':locale.languageCode
    });

    request.fields.addAll({
      'category_id' : categoryId.toString(),
      'family_name' : familyName,
      'area_id' : areaId.toString(),
      'budget' : budget.toString(),
      'date' : date,
      'time' : time,
      'description' : description,
    });

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
        showToastReminder(context, bodyJson['msg']??'Request Added Successfully');
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

  static Future<bool?> deleteSpecialRequest(context, String id) async {
    var request = MultipartRequest('POST', Uri.parse('${AppConstants.DELETE_SPECIAL_REQUEST}$id'));
    log(AppConstants.DELETE_SPECIAL_REQUEST+id.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Locale locale = await getLocale();
    log(id);
    String token = '';
    if (prefs.containsKey(AppConstants.TOKEN)) {
      token = prefs.getString(AppConstants.TOKEN)!;
    }
   //token = prefs.getString("token")!;
    log(token);

    request.headers.addAll({
      //'Accept':'application/json',
      AppConstants.AUTORIZATION:'Bearer $token',
      'Lang':locale.languageCode
    });

    StreamedResponse response = await request.send();

    if(response.statusCode == 200){
      var body = await response.stream.bytesToString();
      log(response.statusCode.toString());
      log(body.toString());
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());

      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        showToastReminder(context, 'Special request Canceled Successfully');
        return true;
      }
    }else{
      showToastError(context, 'we ran into a problem');
      log(response.statusCode.toString());
      return null;
    }
  }

  static Future<SpecialRequestDetails?> sendMessage(context, specialRequestID, content) async{

    var request = MultipartRequest('POST', Uri.parse(AppConstants.SAVE_SPECIAL_REQUEST_DETAILS));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(AppConstants.SAVE_SPECIAL_REQUEST_DETAILS);
    Locale locale = await getLocale();

    String token = '';
    if (prefs.containsKey(AppConstants.TOKEN)) {
      token = prefs.getString(AppConstants.TOKEN)!;
    }
    log(token);

    request.headers.addAll({
      //'Accept':'application/json',
      AppConstants.AUTORIZATION:'Bearer $token',
      'Lang':locale.languageCode
    });
    log(content);
    log(specialRequestID.toString());
    request.fields.addAll({
      'type' : 'text',
      'content' : content,
      'special_requests_id' : specialRequestID.toString(),
    });

    StreamedResponse response = await request.send();

    if(response.statusCode == 200){
      var body = await response.stream.bytesToString();
      log(response.statusCode.toString());
      log(body.toString());
      var bodyJson = jsonDecode(body);
      log(bodyJson['result'].toString());

      if (bodyJson['success'] == false) {
        showToastError(context, bodyJson['msg']);
        return null;
      } else {
        SpecialRequestDetails request = SpecialRequestDetails.fromJson(bodyJson);
        return request;
      }
    }else{
      showToastError(context, 'we ran into a problem');
      log(response.statusCode.toString());
      return null;
    }
  }
}