import 'package:chatnew/Screens/Login/login_controller_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutDialog extends StatelessWidget {
  final Color? color;
  LogoutDialog({Key? key, this.color}) : super(key: key);
  Future<bool> _willPopCallback() async {
    Get.back();

    return true;
  }

  final loginController = Get.put(LoginController2());

  @override
  Widget build(BuildContext context) {
    // var commonService = CommonService.instance;

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: AlertDialog(
          contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 0.0),
          title: Text("Are You Sure you want to logout?",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          content: Wrap(
            children: [
              Center(
                child: Text("You must be signed in to receive notifications, updates, personalised recommendation, and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)),
              ),
              const Divider(),
            ],
          ),
          actions: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: MaterialButton(
                    minWidth: 35,
                    height: 35,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).colorScheme.primary,
                    highlightColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      Future.delayed(Duration.zero, () {
                        loginController.logout().then((val) {
                          // dashBoardController.changeTabIndex(0);
                        });
                      });
                      // Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: MaterialButton(
                    minWidth: 35,
                    height: 35,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).colorScheme.primary,
                    highlightColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            )
          ]),
    );
  }
}