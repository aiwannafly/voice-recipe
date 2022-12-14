import 'package:flutter/material.dart';

import '../../config.dart';

class ClassicButton extends StatefulWidget {
  const ClassicButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.fontSize = 20,
        this.customColor, this.customBorderColor});

  final VoidCallback onTap;
  final String text;
  final double fontSize;
  final Color? customColor;
  final Color? customBorderColor;

  @override
  State<ClassicButton> createState() => _ClassicButtonState();

  static Color get color => Config.darkModeOn ? Colors.grey.shade900
      : Colors.white;

  static Color get hoverColor => Config.darkModeOn ? const Color(0xffc77202)
      : Colors.orangeAccent.shade200;
}

class _ClassicButtonState extends State<ClassicButton> {
  bool _hovered = false;
  bool _pressed = false;
  bool _disposed = false;
  bool _locked = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Color get color => !_hovered & !_pressed
      ? widget.customColor?? ClassicButton.color
      : ClassicButton.hoverColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (h) => setState(() => _hovered = h),
      borderRadius: Config.borderRadiusLarge,
      hoverColor: ClassicButton.hoverColor,
      focusColor: ClassicButton.hoverColor.withOpacity(.5),
      onTap: () {
        if (_locked) return;
        setState(() {
          _locked = true;
          _pressed = true;
        });
        Future.delayed(Config.animationTime, () {
          if (_disposed) return;
          setState(() {
            _pressed = false;
            widget.onTap();
            _locked = false;
          });
        });
      },
      child: AnimatedContainer(
        duration: Config.shortAnimationTime,
        decoration: BoxDecoration(
          color: color,
              borderRadius: Config.borderRadiusLarge
        ),
        padding: const EdgeInsets.all(Config.padding)
            .add(const EdgeInsets.symmetric(horizontal: Config.padding)),
        child: Center(
          child: Text(widget.text,
              style: TextStyle(
                  color: Config.iconColor,
                  fontSize: widget.fontSize,
                  fontFamily: Config.fontFamily
              )
          ),
        ),
      ),
    );
  }
}
