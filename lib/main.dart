// import 'dart:async';
// import 'dart:io';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:chat_app/Screens/Chats/chats_list_view.dart';
// import 'package:chat_app/Screens/Chats/search_chat_list_view.dart';
// import 'package:chat_app/utils/mobile_terms.dart';
// import 'package:chat_app/utils/privacy_policy.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_displaymode/flutter_displaymode.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:chat_app/AppTheme/app_theme.dart';
// import 'package:chat_app/AppTheme/theme_config.dart';
// import 'package:chat_app/Routes/app_pages.dart';
// import 'package:chat_app/initial_binding.dart';

// import 'Screens/Illustration/splash_screen.dart';
// // import 'package:chat_app/utils/firebase_options.dart';

// // Future<void> _firebaseMessagingBackgroundHandlerMessage(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   print("_firebaseMessagingBackgroundHandler Clicked!");
// //   // routeToGo = Routes.TODAY_FOLLOWUPS;
// //   print("printing message: ${message.data}");
// //   if (message.data['screen'] == 1) {
// //     // Get.toNamed(Routes.DASHBOARD_VIEW);
// //   } else {
// //     // Get.toNamed(Routes.TODAY_FOLLOWUPS);
// //   }

// //   print("Printing Notification Data:${message.notification!.body}");
// //   flutterLocalNotificationsPlugin.show(
// //       message.notification.hashCode,
// //       message.notification?.title,
// //       message.notification?.body,
// //       NotificationDetails(
// //         android: AndroidNotificationDetails(
// //           channel.id,
// //           channel.name,
// //         ),
// //       ));
// // }
// Future<void> main() async {
//   await runZonedGuarded(() async {
//     WidgetsFlutterBinding.ensureInitialized();

//     // if(Platform.isIOS){
//     //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//     // }else{
//     //   await Firebase.initializeApp();
//     // }

//     // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandlerMessage);

//     // if (!kIsWeb) {
//     //   channel = const AndroidNotificationChannel(
//     //     'high_importance_channel', // id
//     //     'High Importance Notifications', // title
//     //     description: 'This channel is used for important notifications.', // description
//     //     importance: Importance.high,
//     //   );

//     //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     //   await flutterLocalNotificationsPlugin
//     //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//     //       ?.createNotificationChannel(channel);

//     //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     //     alert: true,
//     //     badge: true,
//     //     sound: true,
//     //   );
//     // }

//     // if (Platform.isAndroid) {
//     //   setOptimalDisplayMode();
//     // }

//     // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
//     //   await Hive.initFlutter('ChatApp');
//     // } else {
//     await Hive.initFlutter();
//     // }
//     await openHiveBox('settings');
//     // await Hive.openBox<UserLoginData>('userData');
//     await openHiveBox('cache', limit: true);
//     await startService();

//     runApp(const MyApp());
//   }, (error, stackTrace) {});
// }

// Future<void> startService() async {
//   if (!GetIt.I.isRegistered<MyTheme>()) {
//     GetIt.I.registerSingleton<MyTheme>(MyTheme());
//   }
//   // GetIt.I.registerSingleton<MyTheme>(MyTheme());
// }

// Future<void> openHiveBox(String boxName, {bool limit = false}) async {
//   final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
//     final Directory dir = await getApplicationDocumentsDirectory();
//     final String dirPath = dir.path;
//     File dbFile = File('$dirPath/$boxName.hive');
//     File lockFile = File('$dirPath/$boxName.lock');
//     if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
//       dbFile = File('$dirPath/ChatApp/$boxName.hive');
//       lockFile = File('$dirPath/ChatApp/$boxName.lock');
//     }
//     await dbFile.delete();
//     await lockFile.delete();
//     await Hive.openBox(boxName);
//     throw 'Failed to open $boxName Box\nError: $error';
//   });
//   // clear box if it grows large
//   if (limit && box.length > 500) {
//     box.clear();
//   }
// }

// Future<void> setOptimalDisplayMode() async {
//   final List<DisplayMode> supported = await FlutterDisplayMode.supported;
//   final DisplayMode active = await FlutterDisplayMode.active;

//   final List<DisplayMode> sameResolution = supported
//       .where(
//         (DisplayMode m) => m.width == active.width && m.height == active.height,
//       )
//       .toList()
//     ..sort(
//       (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
//     );

//   final DisplayMode mostOptimalMode = sameResolution.isNotEmpty ? sameResolution.first : active;

//   await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void dispose() {
//     super.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void initState() {
//     super.initState();

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);

//     AppTheme.currentTheme.addListener(() {
//       setState(() {});
//     });
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         systemNavigationBarColor: AppTheme.themeMode == ThemeMode.dark ? Colors.transparent : Colors.transparent,
//         statusBarIconBrightness: AppTheme.themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
//         systemNavigationBarIconBrightness: AppTheme.themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
//       ),
//     );
//     return WillPopScope(
//       onWillPop: () async => !Navigator.of(context).userGestureInProgress,
//       child: GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         child: GetMaterialApp(
//           smartManagement: SmartManagement.keepFactory,
//           debugShowCheckedModeBanner: false,
//           initialBinding: InitialBinding(),
//           getPages: AppPages.pages,
//           defaultTransition: Transition.native,
//           transitionDuration: const Duration(milliseconds: 3000),
//           title: 'Chat App',
//           themeMode: AppTheme.themeMode,
//           theme: AppTheme.lightTheme(
//             context: context,
//           ),
//           darkTheme: AppTheme.darkTheme(
//             context: context,
//           ),
//           home: const SplashScreen(),
//           builder: EasyLoading.init(),
//         ),
//       ),
//     );
//   }
// }







import 'dart:async';
import 'dart:io';


import 'package:chatnew/CommonComponents/common_services.dart';
import 'package:chatnew/CommonComponents/session_manager.dart';
import 'package:chatnew/Routes/app_pages.dart';
import 'package:chatnew/app_theme.dart';
import 'package:chatnew/initial_binding.dart';
import 'package:chatnew/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'Screens/Illustration/splash_screen.dart';


  var commonService = CommonService.instance;

  isFirstUserOrNot() async {
    commonService.accessToken = await SessionManager.getAccessToken();
    commonService.refreshToken = await SessionManager.getRefreshToken();
    // commonService.username = await SessionManager.getUsername();
    // commonService.fullname = await SessionManager.getFullname();
    // commonService.userProfile = await SessionManager.getUserProfile();
    // commonService.userId = await SessionManager.getUserId();
    // commonService.permissions = await SessionManager.getPermissions();
    // SessionManager.setIsFirstTime(true);
    // commonService.isFirstTime = await SessionManager.getIsFirstTime();
    // debugPrint("isFirstUserOrNot :::::Access Token::::::${commonService.accessToken}");
    // if (commonService.accessToken != '') {
    //   Get.toNamed(Routes.ChatListView);
    // } else {
    //   Get.toNamed(Routes.loginView);
    // }
  }

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    isFirstUserOrNot();
    // if(Platform.isIOS){
    //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // }else{
    //   await Firebase.initializeApp();
    // }

    // if (Platform.isAndroid) {
    //   setOptimalDisplayMode();
    // }

    // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //   await Hive.initFlutter('ChatApp');
    // } else {
    await Hive.initFlutter();
    // }
    await openHiveBox('settings');
    // await Hive.openBox<UserLoginData>('userData');
    await openHiveBox('cache', limit: true);
    await startService();

    runApp(const MyApp());
  }, (error, stackTrace) {});
}

Future<void> startService() async {
  if (!GetIt.I.isRegistered<MyTheme>()) {
    GetIt.I.registerSingleton<MyTheme>(MyTheme());
  }
  // GetIt.I.registerSingleton<MyTheme>(MyTheme());
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/ChatApp/$boxName.hive');
      lockFile = File('$dirPath/ChatApp/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 500) {
    box.clear();
  }
}

Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where(
        (DisplayMode m) => m.width == active.width && m.height == active.height,
      )
      .toList()
    ..sort(
      (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
    );

  final DisplayMode mostOptimalMode = sameResolution.isNotEmpty ? sameResolution.first : active;

  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    AppTheme.currentTheme.addListener(() {
      setState(() {});
    });
  }


  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppTheme.themeMode == ThemeMode.dark ? Colors.transparent : Colors.transparent,
        statusBarIconBrightness: AppTheme.themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: AppTheme.themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
      ),
    );
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: GetMaterialApp(
          smartManagement: SmartManagement.keepFactory,
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBinding(),
          // getPages: AppPages.pages,
          getPages: AppPages.pages,
          defaultTransition: Transition.native,
          transitionDuration: const Duration(milliseconds: 3000),
          title: 'Chat New',
          themeMode: AppTheme.themeMode,
          theme: AppTheme.lightTheme(
            context: context,
          ),
          darkTheme: AppTheme.darkTheme(
            context: context,
          ),
          home: const SplashScreen(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
