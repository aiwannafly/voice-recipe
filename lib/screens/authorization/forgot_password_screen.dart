import 'dart:math';

import 'package:flutter/material.dart';
import 'package:voice_recipe/components/appbars/title_logo_panel.dart';
import 'package:voice_recipe/components/buttons/classic_button.dart';
import 'package:voice_recipe/components/labels/input_label.dart';
import 'package:voice_recipe/model/auth/auth.dart';
import 'package:voice_recipe/screens/authorization/login_screen.dart';

import '../../config.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const route = '/reset-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String get email => _emailController.text.trim();

  @override
  Widget build(BuildContext context) {
    var width = Config.loginPageWidth(context);
    return Scaffold(
      appBar: const TitleLogoPanel(
        title: Config.appName,
      ).appBar(),
      body: GestureDetector(
        onTap: () => _emailFocusNode.unfocus(),
        child: Container(
          color: Config.backgroundEdgeColor,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: width,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(Config.margin),
              padding: const EdgeInsets.all(Config.margin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Config.pageHeight(context) / 3,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/images/voice_recipe.png"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(Config.padding).add(
                        const EdgeInsets.symmetric(horizontal: Config.padding)),
                    width: width * .85,
                    alignment: Alignment.center,
                    child: Text(
                        "?????????????? ???????? email, ?????????? ???? ???????????????? ??????"
                        " ???????????? ?? ?????????????????????? ???? ?????????? ????????????.",
                        style: TextStyle(
                            color: Config.iconColor,
                            fontFamily: Config.fontFamily,
                            fontSize: 20)),
                  ),
                  const SizedBox(
                    height: Config.margin,
                  ),
                  LoginScreen.inputWrapper(
                      InputLabel(
                          onSubmit: () => AuthenticationManager()
                              .passwordReset(context, email),
                          focusNode: _emailFocusNode,
                          labelText: "Email",
                          controller: _emailController),
                      context),
                  const SizedBox(
                    height: Config.margin,
                  ),
                  SizedBox(
                      height: 60,
                      width: width * 0.8,
                      child: ClassicButton(
                        onTap: () => AuthenticationManager()
                            .passwordReset(context, email),
                        text: "?????????????? ????????????",
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
