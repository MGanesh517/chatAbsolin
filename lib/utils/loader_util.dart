import 'package:chatnew/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';


const tokenBox = "token";
void configLoading() {
  EasyLoading.instance
    // ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = AppTheme.themeMode == ThemeMode.dark ? EasyLoadingStyle.dark : EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Get.theme.colorScheme.primary
    ..backgroundColor = Colors.green
    ..indicatorColor = Get.theme.colorScheme.primary
    ..indicatorWidget = CircularProgressIndicator(
      color: AppTheme.themeMode == ThemeMode.dark ? Colors.white : Get.theme.colorScheme.primary,
    )
    ..textColor = Get.theme.colorScheme.primary
    ..maskColor = AppTheme.themeMode == ThemeMode.dark
        ? Colors.white.withOpacity(0.1)
        : Get.theme.colorScheme.primary.withOpacity(0.1)
    // ..userInteractions = true
    ..maskType = EasyLoadingMaskType.custom
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

showLoadingDialog({String? title, String? subTitle}) {
  configLoading();
  EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.scale;

  // return Get.dialog(
  //   LoadingDialog(
  //     color: Get.theme.primaryColor,
  //     loderTitle: title,
  //     loderSubTitle: subTitle,
  //   ),
  //   barrierDismissible: false,
  //   useSafeArea: false,
  // );
  return EasyLoading.show(status: title);
}

closeLoadingDialog() {
  return EasyLoading.dismiss();
  // if (Get.isDialogOpen!) {
  //   return Get.back();
  // }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
