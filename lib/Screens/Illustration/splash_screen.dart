import 'dart:async';
import 'dart:io';
import 'package:chatnew/CommonComponents/common_services.dart';
import 'package:chatnew/CommonComponents/gradient_containers.dart';
import 'package:chatnew/CommonComponents/session_manager.dart';
import 'package:chatnew/Routes/app_pages.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    _initPackageInfo();

    _getId().then((id) {
      commonService.deviceId = id;
      commonService.deviceType = Platform.operatingSystem;
    });
    // ignore: prefer_const_constructors
    Timer(Duration(seconds: 3), () => isFirstUserOrNot());
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    commonService.packageInfo = info;
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    debugPrint("deviceInfo :::: ${deviceInfo}");
    print('deviceInfo :::: ${deviceInfo}');
    // if (kIsWeb) {
    //   var webDeviceInfo = await deviceInfo.webBrowserInfo;
    //   debugPrint(
    //     "browserName :::: ${webDeviceInfo.browserName.name}",
    //   );
    //   debugPrint(
    //     "appCodeName :::: ${webDeviceInfo.appCodeName}",
    //   );
    //   debugPrint(
    //     "appName :::: ${webDeviceInfo.appName}",
    //   );
    //   debugPrint(
    //     "appVersion :::: ${webDeviceInfo.appVersion}",
    //   );
    //   debugPrint(
    //     "deviceMemory :::: ${webDeviceInfo.deviceMemory}",
    //   );
    //   debugPrint(
    //     "language :::: ${webDeviceInfo.language}",
    //   );
    //   debugPrint(
    //     "platform :::: ${webDeviceInfo.platform}",
    //   );
    //   debugPrint(
    //     "product :::: ${webDeviceInfo.product}",
    //   );
    //   debugPrint(
    //     "productSub :::: ${webDeviceInfo.productSub}",
    //   );
    //   debugPrint(
    //     "userAgent :::: ${webDeviceInfo.userAgent}",
    //   );
    //   debugPrint(
    //     "vendor :::: ${webDeviceInfo.vendor}",
    //   );
    //   debugPrint(
    //     "vendorSub :::: ${webDeviceInfo.vendorSub}",
    //   );
    //   debugPrint(
    //     "hardwareConcurrency :::: ${webDeviceInfo.hardwareConcurrency}",
    //   );
    //   debugPrint(
    //     "maxTouchPoints :::: ${webDeviceInfo.maxTouchPoints}",
    //   );

    //   final deviceId = DeviceId.getDeviceId();
    //   debugPrint('Device ID: $deviceId ');
    //   return deviceId;
    // } else
     if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor!; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  var commonService = CommonService.instance;

  isFirstUserOrNot() async {
    commonService.accessToken = await SessionManager.getAccessToken();
    commonService.refreshToken = await SessionManager.getRefreshToken();
    commonService.username = await SessionManager.getUsername();
    commonService.fullname = await SessionManager.getFullname();
    commonService.userProfile = await SessionManager.getUserProfile();
    commonService.userId = await SessionManager.getUserId();
    commonService.permissions = await SessionManager.getPermissions();
    SessionManager.setIsFirstTime(true);
    commonService.isFirstTime = await SessionManager.getIsFirstTime();
    debugPrint("isFirstUserOrNot :::::Access Token::::::${commonService.accessToken}");
    if (commonService.accessToken != '') {
      Get.toNamed(Routes.chatListView);
      // Get.offAllNamed('/loginView');
    } else {
      Get.toNamed(Routes.loginView);
      // Get.offAllNamed('/loginView');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: const Center(child: FlutterLogo(size: 100)),
    );
  }
}
