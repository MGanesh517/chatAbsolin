import 'package:chatnew/CommonComponents/common_components.dart';
import 'package:chatnew/Screens/Login/login_controller_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginController2());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: GetBuilder<LoginController2>(
        builder: (value) => SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return _buildLoginForm(context);
                    } else {
                      return Center(
                        child: SizedBox(
                          width: 500,
                          child: _buildLoginForm(context),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(15),
            //   topRight: Radius.circular(15),
            //   bottomLeft: Radius.circular(15),
            //   bottomRight: Radius.circular(15),
            // ),
          border: Border.all(width: 2, color: Colors.grey , style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.userLogin();
                          }
                        },
                        height: 45,
                        color: Theme.of(context).colorScheme.primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Center(
                          child: Text(
                            "Login In",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Sign in with your Username and Password",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Username',
                          hintText: 'Enter Username',
                          controller: controller.usernameController,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9" "]'))],
                          validator: (String? val) {
                            if (val == '') {
                              return 'Please enter a valid username';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChange: (val) {},
                        ),
                        Container(height: 20),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Password',
                          hintText: 'Enter Password',
                          obscureText: controller.obscureText,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))],
                          validator: (String? val) {
                            if (val == '' || val!.length < 3) {
                              return 'Please enter a valid password';
                            } else {
                              return null;
                            }
                          },
                          onChange: (val) {},
                          suffixIcon: IconButton(
                            color: Colors.grey,
                            icon: Icon(
                              controller.obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              setState(() {
                                controller.obscureText = !controller.obscureText;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 60,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}