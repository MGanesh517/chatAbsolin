import 'package:package_info_plus/package_info_plus.dart';

class CommonService {
  static final CommonService _singleton = CommonService._internal();
  CommonService._internal();
  static CommonService get instance => _singleton;

  int pageSize = 15;
  String deviceId = "";
  String deviceType = "";
  int counter = 0;
  RegExp panCardPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  bool rememberMe = false;
  bool userDefaultPassword = false;
  String accessToken = "";
  String refreshToken = "";
  String username = "";
  String fullname = "";
  String userProfile = "";
  String userId = "";
  List<String> permissions = [];
  String? pushToken;
  String? apnsToken;
  bool isFirstTime = false;

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
}
