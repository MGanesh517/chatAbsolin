import 'dart:convert';

import 'package:chatnew/CommonComponents/common_services.dart';
import 'package:chatnew/CommonComponents/session_manager.dart';
import 'package:chatnew/CommonComponents/snack_bar_widget.dart';
import 'package:chatnew/Screens/Login/Repo/login_repo.dart';
import 'package:chatnew/utils/loader_util.dart';
import 'package:chatnew/utils/soket_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class LoginController2 extends GetxController {
  static LoginController2 get to => Get.find();
  var commonService = CommonService.instance;

  initSigninState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      obscureText = true;

      // selectedValue = 1;
      if (commonService.accessToken != '') {
        Get.toNamed(Routes.chatListView);
      } else {
        Get.toNamed(Routes.loginView);
      }
      // stateTimerStart();
    });
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RxBool _obscureText = true.obs;
  get obscureText => _obscureText.value;
  set obscureText(value) => _obscureText.value = value;

  showPassword() {
    obscureText = !obscureText;
    update();
  }

  final RxBool _submitData = false.obs;
  RxBool get submitData => _submitData;
  set submitData(value) => _submitData.value = value;

  userLogin() async {
    submitData = true;
    debugPrint("user Login:::");
    var loginObj = {
      "password": passwordController.text,
      "username": usernameController.text,
      // "user_type": "String",
      // "device_name": commonService.deviceType,
      "device_uuid": commonService.deviceId,
      // "device_type": Platform.isIOS ? "2" : "1",
      // "device_fcmtoken": "string",
      // "device_apntoken": "string"
    };

    debugPrint("Print User Post Data:::$loginObj");

    showLoadingDialog();
    try {
      closeLoadingDialog();
      var data = await LogInRepo().login(loginObj);

      closeLoadingDialog();
      if (data != null) {
        submitData = false;
        debugPrint('Printing Dtata:${jsonEncode(data)}');
        // var tokens = data.tokens;
        // var useType = data["groups"];

        commonService.accessToken = data.tokens != null && data.tokens!.access != null ? data.tokens!.access ?? '' : '';
        commonService.refreshToken = data.tokens != null && data.tokens!.refresh != null ? data.tokens!.refresh ?? '' : '';
        commonService.username = data.user!.username ?? '';
        commonService.userId = data.user!.id ?? '';


        SessionManager.setAccessToken(data.tokens != null && data.tokens!.access != null ? data.tokens!.access ?? '' : '');
        SessionManager.setUserId(data.user != null ? data.user!.id ?? '' : '');
        SessionManager.setRefreshToken(data.tokens != null && data.tokens!.refresh != null ? data.tokens!.refresh ?? '' : '');
        usernameController.clear();
        SocketUtils.socketLogin();
        passwordController.clear();
        Get.toNamed(Routes.chatListView);

        return true;
      } else {
        submitData = false;
        Get.snackbar("Login..! Failed", "PLease Try Again Later",
            icon: const Icon(Icons.close, color: Colors.red),
            duration: const Duration(milliseconds: 1500),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white);
        debugPrint("Api Error Response error:: ");
        return false;
      }
    } catch (e) {
      debugPrint(
        "user login error: $e",
      );
      closeLoadingDialog();
      submitData = false;
      Get.snackbar("Login..! Failed", e.toString(),
          icon: const Icon(Icons.close, color: Colors.red),
          duration: const Duration(milliseconds: 1500),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white);
      rethrow;
      // return false;

    }
  }

  logout({String? title}) async {
    showLoadingDialog();
    try {
      closeLoadingDialog();
      await LogInRepo().userLogout(commonService.refreshToken, commonService.deviceId, commonService.deviceType).then((value) async {
        if (value) {
          commonService.accessToken = '';
          commonService.refreshToken = '';
          commonService.username = '';
          // commonService.fullname = '';
          // var db = DatabaseHelper();
          // await db.clearCart();
          SessionManager.setAccessToken('');
          SessionManager.setRefreshToken('');
          // SessionManager.setUsername('');
          // SessionManager.setFullname('');
          // SessionManager.setPermissions(['']);
          debugPrint("SplashScreen accessToken: ${commonService.accessToken}");
          debugPrint("SplashScreen refreshToken: ${commonService.refreshToken}");
          // debugPrint("SplashScreen username: ${commonService.username}");
          // debugPrint("SplashScreen fullname: ${commonService.fullname}");
        }

        // if (title == 'logout') {
        //   showSnackBar(
        //     title: "logout..! Success",
        //     message: 'You have been successfully logged out.',
        //     icon: const Icon(Icons.check_circle_outline, color: Colors.green),
        //   );
        // }
        closeLoadingDialog();
        await Get.toNamed(Routes.loginView);
        update();
      });
    } catch (e) {
      closeLoadingDialog();
      showSnackBar(
        title: "logout..! Failed",
        message: "Please try again",
        icon: const Icon(Icons.close, color: Colors.red),
      );
    }
  }
}
