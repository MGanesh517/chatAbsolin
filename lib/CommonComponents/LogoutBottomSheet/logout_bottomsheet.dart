// import 'package:chatnew/Screens/Login/login_controller_2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class LogoutBottomSheetWidget extends StatelessWidget {
//    LogoutBottomSheetWidget({super.key});
//   final controller = Get.put(LoginController2());
//   final RefreshController refreshController = RefreshController(initialRefresh: false);


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//           color: Theme.of(context).colorScheme.primary,
//         ),
//         height: 250,
//         child: Stack(alignment: Alignment.center, children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             child: Column(
//               children: [
//               Container(height: 50),
//               Text(
//                 "Are you sure you want to logout?",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.secondary,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ]),
//           ),
//           Positioned(
//             bottom: 35,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MaterialButton(
//                   minWidth: 150,
//                   height: 46,
//                   elevation: 0.0,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                   color: Theme.of(context).colorScheme.secondary,
//                   onPressed: () {
//                     Get.back();
//                     // Get.toNamed(Routes.SERVICE_ENQUIRIES_DETAILS_VIEW);
//                   },
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(
//                       // color: Theme.of(context).colorScheme.surface,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 20,
//                 ),
//                 MaterialButton(
//                   minWidth: 150,
//                   height: 42,
//                   elevation: 0.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     side: BorderSide(
//                       color: Theme.of(context).colorScheme.secondary,
//                       width: 1.5,
//                     ),
//                   ),
//                   color: Get.theme.primaryColor,
//                   onPressed: () {
//                     Get.back();
//                     Future.delayed(Duration.zero, () {
//                     controller.logout(title: 'logout').then((val) {
//                       // dashBoardController.changeTabIndex(0);
//                     });
//                   });
//                     // Get.toNamed(Routes.signInPage);
//                     // Get.back();
//                   },
//                   child: Text(
//                     'Logout',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.secondary,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ]));
//   }
// }
