import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar({required String title, required String message, required Widget icon}) {
  Get.snackbar(
    title,
    message,
    icon: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: (53),
        width: (53),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: icon,
      ),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
    borderRadius: (10),
    boxShadows: [
      const BoxShadow(
        color: Colors.black,
        spreadRadius: 0.5,
        blurRadius: 2,
        offset: Offset(0, 2), // changes position of shadow
      ),
    ],
    margin: const EdgeInsets.all(15),
    colorText: Colors.black,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
