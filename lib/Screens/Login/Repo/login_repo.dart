// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:chatnew/CommonComponents/common_services.dart';
import 'package:chatnew/Screens/Login/Models/login_user_data_model.dart';
import 'package:chatnew/utils/loader_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../utils/http_utils.dart';

class LogInRepo {
  var commonService = CommonService.instance;

  Future<LoginModel?> login(signupData) async {
    print("printing response ::::: $signupData");
    try {
      var response = await HttpUtils.postInstance().post("v1/auth/login/", data: signupData);
    print("Response response ::::: ${response.data}.");

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        closeLoadingDialog();

        return LoginModel.fromJson(response.data as Map<String, dynamic>);
      }

      return null;
    } on DioException catch (e) {
      debugPrint('error message $e');
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<bool> userLogout(String? refresh, String? deviceId, String? deviceType) async {
    debugPrint("Printing refresh: $refresh");
    debugPrint("Printing access: ${CommonService.instance.accessToken}");
    var refreshObj = jsonEncode({'refresh': refresh, 'device_uuid': deviceId, 'device_type': deviceType == 'android' ? 1 : 2});
    debugPrint("Printing refresh: $refreshObj");

    try {
      var response = await HttpUtils.getInstance().post("/users/logout/", data: refreshObj);
      debugPrint("response.toString()::::::::::::::::::${response.statusCode}");
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }
}
