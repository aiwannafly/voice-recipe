import 'dart:async';

import 'package:flutter/material.dart';

import 'package:voice_recipe/components/util.dart';

class CookTimer extends StatefulWidget {
  CookTimer({super.key, required this.waitTimeMins});

  final int waitTimeMins;
  Duration? _leftDuration;
  bool _isDisposed = false;
  bool _isTimerActive = false;
  Timer? _timer;

  @override
  State<CookTimer> createState() => _CookTimerState();
}

class _CookTimerState extends State<CookTimer> {
  static const _height = 0.1;
  static const _iconHeight = 0.1 * 0.6;
  bool _isTimerActive = false;

  @override
  void initState() {
    super.initState();
    _isTimerActive = widget._isTimerActive;
    widget._leftDuration ??= Duration(minutes: widget.waitTimeMins);
    if (widget._isDisposed && _isTimerActive) {
      widget._timer!.cancel();
      startTimer();
    }
    widget._isDisposed = false;
  }

  @override
  void dispose() {
    super.dispose();
    widget._isTimerActive = _isTimerActive;
    widget._isDisposed = true;
  }

  void startTimer() {
    _isTimerActive = true;
    widget._timer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    _isTimerActive = false;
    setState(() => widget._timer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => widget._leftDuration = Duration(minutes: widget.waitTimeMins));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds =  widget._leftDuration!.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      widget._timer!.cancel();
    } else {
      widget._leftDuration = Duration(seconds: seconds);
    }
    if (!widget._isDisposed) {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Util.borderRadiusLarge)),
      height: Util.pageHeight(context) * _height,
      margin: const EdgeInsets.fromLTRB(0, Util.margin, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          timerButton(onPressed: () {
            setState(() {
              _isTimerActive = !_isTimerActive;
            });
            if (_isTimerActive) {
              startTimer();
            } else {
              stopTimer();
            }
          }, icon: Icon(
            _isTimerActive ? Icons.pause_circle : Icons.play_circle,
            color: Colors.black87.withOpacity(0.8),
          )),
          timeLabel(),
          timerButton(onPressed: () {
            setState(() {
              resetTimer();
            });
          }, icon: Icon(
            Icons.replay_circle_filled_rounded,
            color: Colors.black87.withOpacity(0.8),
          ))
        ],
      ),
    );
  }

  Widget timerButton({required void Function() onPressed, required Icon icon}) {
    return Container(
      padding: const EdgeInsets.all(Util.padding),
      child: IconButton(
          onPressed: onPressed,
          iconSize: _iconHeight * Util.pageHeight(context),
          icon: icon),
    );
  }

  Widget timeLabel() {
    const labelWidth = 0.3;
    const fontSize = 0.05;
    String strDigits(int n) => n.toString().padLeft(2, '0');
    widget._leftDuration ??= Duration(minutes: widget.waitTimeMins);
    final hours = strDigits( widget._leftDuration!.inHours.remainder(24));
    final minutes = strDigits( widget._leftDuration!.inMinutes.remainder(60));
    final seconds = strDigits( widget._leftDuration!.inSeconds.remainder(60));
    return Container(
      alignment: Alignment.center,
      width: labelWidth * Util.pageWidth(context),
      child: Text(
        widget._leftDuration!.inHours == 0
            ? "$minutes:$seconds"
            : "$hours:$minutes:$seconds",
        style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: fontSize * Util.pageHeight(context),
            color: Colors.black87),
      ),
    );
  }
}



// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import 'package:voice_recipe/components/util.dart';
// import 'package:voice_recipe/shared_data.dart';
//
// class CookTimer extends StatefulWidget {
//   CookTimer({super.key, required this.waitTimeMins, required this.slideId});
//
//   final int waitTimeMins;
//   final int slideId;
//   Duration? _leftDuration;
//   bool _isDisposed = false;
//   bool _isTimerActive = false;
//   Timer? _timer;
//
//   @override
//   State<CookTimer> createState() => _CookTimerState();
// }
//
// class _CookTimerState extends State<CookTimer> {
  // bool _isTimerActive = false;
  // static const _height = 0.1;
  // static const _iconHeight = 0.1 * 0.6;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _isTimerActive = widget._isTimerActive;
  //   widget._leftDuration ??= Duration(minutes: widget.waitTimeMins);
  //   if (SharedData.getLeftDurs().containsKey(widget.slideId)) {
  //     widget._leftDuration = SharedData.getLeftDurs()[widget.slideId];
  //   }
  //   if (widget._isDisposed && _isTimerActive) {
  //     widget._timer?.cancel();
  //     startTimer();
  //   }
  //   widget._isDisposed = false;
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   widget._isDisposed = true;
  //   SharedData.getLeftDurs()[widget.slideId] = widget._leftDuration;
  // }
  //
  // void startTimer() {
  //   _isTimerActive = true;
  //   widget._timer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  // }
  //
  // void stopTimer() {
  //   _isTimerActive = false;
  //   setState(() => widget._timer!.cancel());
  // }
  //
  // void resetTimer() {
  //   stopTimer();
  //   setState(() => widget._leftDuration = Duration(minutes: widget.waitTimeMins));
  // }
  //
  // void setCountDown() {
  //   const reduceSecondsBy = 1;
  //   final seconds =  widget._leftDuration!.inSeconds - reduceSecondsBy;
  //   if (seconds < 0) {
  //     widget._timer!.cancel();
  //   } else {
  //     widget._leftDuration = Duration(seconds: seconds);
  //   }
  //   if (!widget._isDisposed) {
  //     setState(() {
  //     });
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(Util.borderRadiusLarge)),
  //     height: Util.pageHeight(context) * _height,
  //     margin: const EdgeInsets.fromLTRB(0, Util.margin, 0, 0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         timerButton(onPressed: () {
  //           setState(() {
  //             _isTimerActive = !_isTimerActive;
  //           });
  //           if (_isTimerActive) {
  //             startTimer();
  //           } else {
  //             stopTimer();
  //           }
  //         }, icon: Icon(
  //           _isTimerActive ? Icons.pause_circle : Icons.play_circle,
  //           color: Colors.black87.withOpacity(0.8),
  //         )),
  //         timeLabel(),
  //         timerButton(onPressed: () {
  //           setState(() {
  //             resetTimer();
  //           });
  //         }, icon: Icon(
  //           Icons.replay_circle_filled_rounded,
  //           color: Colors.black87.withOpacity(0.8),
  //         ))
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget timerButton({required void Function() onPressed, required Icon icon}) {
  //   return Container(
  //     padding: const EdgeInsets.all(Util.padding),
  //     child: IconButton(
  //         onPressed: onPressed,
  //         iconSize: _iconHeight * Util.pageHeight(context),
  //         icon: icon),
  //   );
  // }
  //
  // Widget timeLabel() {
  //   const labelWidth = 0.3;
  //   const fontSize = 0.05;
  //   String strDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = strDigits( widget._leftDuration!.inHours.remainder(24));
  //   final minutes = strDigits( widget._leftDuration!.inMinutes.remainder(60));
  //   final seconds = strDigits( widget._leftDuration!.inSeconds.remainder(60));
  //   return Container(
  //     alignment: Alignment.center,
  //     width: labelWidth * Util.pageWidth(context),
  //     child: Text(
  //       widget._leftDuration!.inHours == 0
  //           ? "$minutes:$seconds"
  //           : "$hours:$minutes:$seconds",
  //       style: TextStyle(
  //           fontFamily: "Montserrat",
  //           fontSize: fontSize * Util.pageHeight(context),
  //           color: Colors.black87),
  //     ),
  //   );
  // }
// }