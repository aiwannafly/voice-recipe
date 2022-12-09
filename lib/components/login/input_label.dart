import 'package:flutter/material.dart';

import '../../config.dart';

class InputLabel extends StatelessWidget {
  const InputLabel(
      {super.key,
      required this.hintText,
      required this.controller,
      this.focusNode,
      this.onSubmit});

  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onSubmit;

  static InputDecoration buildInputDecoration(String hintText,
          [Widget? suffixIcon]) =>
      InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: Config.iconColor.withOpacity(0.7),
              fontFamily: Config.fontFamily),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black87),
              borderRadius: Config.borderRadiusLarge),
          focusedBorder: OutlineInputBorder(
              borderRadius: Config.borderRadiusLarge,
              borderSide: BorderSide(
                  color:
                      Config.darkModeOn ? Colors.orangeAccent : Colors.black)),
          fillColor: Config.darkModeOn ? Colors.white12 : Colors.white70,
          filled: true,
          suffixIcon: suffixIcon);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Config.borderRadius,
      child: TextFormField(
            onFieldSubmitted: (s) {
              if (onSubmit == null) return;
              onSubmit!();
            },
            focusNode: focusNode,
            controller: controller,
            decoration: buildInputDecoration(hintText),
            style: TextStyle(
                color: Config.iconColor.withOpacity(0.8),
                fontSize: 18,
                fontFamily: Config.fontFamily),
          ),

    );
  }
}
