import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_app/router.dart';
import 'package:template_app/utils/app_assets.dart';
import 'package:template_app/utils/app_colors.dart';

class LoginView extends StatefulWidget {

  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", loginController.text);
    await prefs.setString("password", passwordController.text);

    AppRouter.push(context, NavPosition.inHome, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Lottie.asset(AppAssets.animatedBackground,
            fit: BoxFit.cover, width: double.infinity,
            height: double.infinity),
        SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Username", textAlign: TextAlign.start,
                    style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12, top: 4),
                    child: TextFormField(
                      controller: loginController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Enter your username',
                        fillColor: AppColors.gray100,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username missing';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Text("Password", textAlign: TextAlign.start,
                    style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8, top: 4),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelStyle: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 18),
                          labelText: 'Enter your password',
                          fillColor: AppColors.gray100,
                          filled: true
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password missing';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        } else {
                          // log("Form is not valid");
                        }
                      },
                      child: Container(
                        width: 160,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: const Text("Login",
                          style: TextStyle(color: AppColors.onBackground, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }

}
