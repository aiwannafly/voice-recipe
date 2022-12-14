import 'package:flutter/material.dart';

import '../../config.dart';
import 'package:rive/rive.dart';

enum Direction { left, right }

class ArrowButton extends StatefulWidget {
  const ArrowButton({
    super.key,
    required this.direction,
    required this.onTap,
  });

  final Direction direction;
  final VoidCallback onTap;

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
    while (pressed) {
      widget.onTap();
      await Future.delayed(const Duration(milliseconds: 350));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                onInit: _onArrowInit)));
  }
}
