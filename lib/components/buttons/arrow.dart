import 'package:flutter/material.dart';

import '../../config/config.dart';
import 'package:rive/rive.dart';

enum Direction { left, right }

class ArrowButton extends StatefulWidget {
  const ArrowButton({
    super.key,
    required this.direction,
    required this.onTap,
    required this.hideNotify
  });

  final Direction direction;
  final VoidCallback onTap;
  final ValueNotifier<bool> hideNotify;

  @override
  State<ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<ArrowButton> {
  SMIBool? hovered;

  void _onArrowInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller == null) return;
    artboard.addController(controller!);
    hovered = controller.findInput<bool>('Hover') as SMIBool;
  }

  String get imageName =>
      widget.direction == Direction.right ? "right" : "left";

  String get postfix => Config.darkModeOn ? "" : "_light";

  int get turn => widget.direction == Direction.right ? 3 : 1;

  bool pressed = false;

  DateTime lastCallTime = DateTime.now();

  void onTap() async {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.hideNotify,
      builder: (context, isHidden, child) {
        return Visibility(
            visible: !isHidden,
            child: child!
        );
      },
      child: InkWell(
          onTapDown: (d) {
            pressed = true;
            onTap();
          },
          onTapUp: (d) {
            pressed = false;
          },
          onHover: (h) {
            hovered?.change(h);
          },
          child: RotatedBox(
              quarterTurns: turn,
              child: RiveAnimation.asset(
                  "assets/RiveAssets/arrow_down$postfix.riv",
                  onInit: _onArrowInit))),
    );
  }
}
