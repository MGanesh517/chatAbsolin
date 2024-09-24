import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // login authentication
  // static Future setRememberMe(bool rememberMe) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('rememberMe', rememberMe);
  // }

  // static Future getRememberMe() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final rememberMe = prefs.getBool('rememberMe');
  //   if (rememberMe == null) {
  //     return false;
  //   } else {
  //     return rememberMe;
  //   }
  // }

  static Future setAccessToken(String? accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken!);
  }

  static Future getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    debugPrint("getAccessToken:::::: $accessToken");
    if (accessToken == null) {
      return '';
    } else {
      return accessToken;
    }
  }

  static Future setRefreshToken(String? refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', refreshToken!);
  }

  static Future getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    if (refreshToken == null) {
      return '';
    } else {
      return refreshToken;
    }
  }

  static Future setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username == null) {
      return '';
    } else {
      return username;
    }
  }

  static Future setFullname(String fullname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullname', fullname);
  }

  static Future getFullname() async {
    final prefs = await SharedPreferences.getInstance();
    final fullname = prefs.getString('fullname');
    if (fullname == null) {
      return '';
    } else {
      return fullname;
    }
  }

  static Future setUserProfile(String userProfile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', userProfile);
  }

  static Future getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userProfile = prefs.getString('userProfile');
    if (userProfile == null) {
      return '';
    } else {
      return userProfile;
    }
  }

  static Future setCounter(int? counter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter!);
  }

  static Future getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('counter');
    if (counter == null) {
      return 0;
    } else {
      return counter;
    }
  }

  static Future setPermissions(List<String> permissions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('permissions', permissions);
  }

  static Future getPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('permissions') != null) {
      final permissions = prefs.getStringList('permissions');
      return permissions;
    } else {
      final permissions = [''];
      return permissions;
    }
  }

  static Future setUserId(String? userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId!);
  }

  static Future getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId == null) {
      return '';
    } else {
      return userId;
    }
  }

  static Future setUserDefaultPassword(bool? userDefaultPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userDefaultPassword', userDefaultPassword!);
  }

  static Future getUserDefaultPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final userDefaultPassword = prefs.getBool('userDefaultPassword');
    if (userDefaultPassword == null) {
      return true;
    } else {
      return userDefaultPassword;
    }
  }

  static Future setIsFirstTime(bool firstTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', firstTime);
  }

  static Future getIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final firstTime = prefs.getBool('isFirstTime');
    if (firstTime == null) {
      return false;
    } else {
      return firstTime;
    }
  }
}








// import 'dart:io' show Platform; // For platform check (Mobile or Web)
// import 'package:flutter/foundation.dart' show kIsWeb; // For web check
// import 'dart:html' as html; // For web-specific localStorage
// import 'package:shared_preferences/shared_preferences.dart'; // For mobile
// import 'package:flutter/material.dart';

// class SessionManager {
  
//   // Method to check platform and decide whether to use localStorage or SharedPreferences
//   static Future<void> setAccessToken(String? accessToken) async {
//     if (kIsWeb) {
//       // Web: Use localStorage
//       html.window.localStorage['accessToken'] = accessToken!;
//     } else {
//       // Mobile/Desktop: Use SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('accessToken', accessToken!);
//     }
//   }

//   static Future<String?> getAccessToken() async {
//     if (kIsWeb) {
//       // Web: Retrieve from localStorage
//       final accessToken = html.window.localStorage['accessToken'];
//       debugPrint("getAccessToken from localStorage: $accessToken");
//       return accessToken ?? '';
//     } else {
//       // Mobile/Desktop: Retrieve from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final accessToken = prefs.getString('accessToken');
//       debugPrint("getAccessToken from SharedPreferences: $accessToken");
//       return accessToken ?? '';
//     }
//   }

//   static Future<void> setRefreshToken(String? refreshToken) async {
//     if (kIsWeb) {
//       // Web: Use localStorage
//       html.window.localStorage['refreshToken'] = refreshToken!;
//     } else {
//       // Mobile/Desktop: Use SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('refreshToken', refreshToken!);
//     }
//   }

//   static Future<String?> getRefreshToken() async {
//     if (kIsWeb) {
//       // Web: Retrieve from localStorage
//       final refreshToken = html.window.localStorage['refreshToken'];
//       return refreshToken ?? '';
//     } else {
//       // Mobile/Desktop: Retrieve from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final refreshToken = prefs.getString('refreshToken');
//       return refreshToken ?? '';
//     }
//   }

//   static Future<void> setDeviceId(String? deviceId) async {
//     if (kIsWeb) {
//       // Web: Use localStorage
//       html.window.localStorage['deviceId'] = deviceId!;
//     } else {
//       // Mobile/Desktop: Use SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('deviceId', deviceId!);
//     }
//   }

//   static Future<String?> getDeviceId() async {
//     if (kIsWeb) {
//       // Web: Retrieve from localStorage
//       final deviceId = html.window.localStorage['deviceId'];
//       return deviceId ?? '';
//     } else {
//       // Mobile/Desktop: Retrieve from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final deviceId = prefs.getString('deviceId');
//       return deviceId ?? '';
//     }
//   }

//   // You can apply the same logic for other fields like username, fullname, etc.

//   static Future<void> setUsername(String username) async {
//     if (kIsWeb) {
//       html.window.localStorage['username'] = username;
//     } else {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('username', username);
//     }
//   }

//   static Future<String?> getUsername() async {
//     if (kIsWeb) {
//       return html.window.localStorage['username'] ?? '';
//     } else {
//       final prefs = await SharedPreferences.getInstance();
//       return prefs.getString('username') ?? '';
//     }
//   }


//   static Future<void> setFullname(String fullname) async {
//     if (kIsWeb) {
//       html.window.localStorage['username'] = fullname;
//     } else {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('username', fullname);
//     }
//   }

//     static Future<String?> getFullname() async {
//     if (kIsWeb) {
//       return html.window.localStorage['fullname'] ?? '';
//     } else {
//       final prefs = await SharedPreferences.getInstance();
//       return prefs.getString('fullname') ?? '';
//     }
//   }

// static Future<void> setIsFirstTime(bool isFirstTime) async {
//   if (kIsWeb) {
//     // Web: Store as a string in localStorage
//     html.window.localStorage['isFirstTime'] = isFirstTime.toString();
//   } else {
//     // Mobile/Desktop: Store as a boolean in SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isFirstTime', isFirstTime);
//   }
// }

// static Future<bool> getIsFirstTime() async {
//   if (kIsWeb) {
//     // Web: Retrieve and convert from string
//     final isFirstTimeString = html.window.localStorage['isFirstTime'];
//     return isFirstTimeString == 'true';
//   } else {
//     // Mobile/Desktop: Retrieve directly as a boolean
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isFirstTime') ?? false;
//   }
// }

//   // Repeat similar methods for fullname, userProfile, etc.

//   static Future<void> clearSession() async {
//     if (kIsWeb) {
//       // Clear localStorage for web
//       html.window.localStorage.clear();
//     } else {
//       // Clear SharedPreferences for mobile/desktop
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.clear();
//     }
//   }
// }


// // static Future setIsFirstTime(bool firstTime) async {
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setBool('isFirstTime', firstTime);
// //   }

// //   static Future getIsFirstTime() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final firstTime = prefs.getBool('isFirstTime');
// //     if (firstTime == null) {
// //       return false;
// //     } else {
// //       return firstTime;
// //     }
// //   }