import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:voice_recipe/model/recipes_info.dart';
import 'package:voice_recipe/components/header_buttons_panel.dart';
import 'package:voice_recipe/config.dart';
import 'package:voice_recipe/components/timer_view.dart';

class RecipeStepView extends StatefulWidget {
  RecipeStepView({Key? key, required this.recipe, required this.slideId})
      : super(key: key) {
    int len = getStepsCount(recipe.id);
    int idx = min(slideId - 2, len - 1);
    step = getStep(recipe.id, idx);
    tts.setLanguage("ru");
  }

  static final FlutterTts tts = FlutterTts();
  final Recipe recipe;
  final int slideId;
  late final RecipeStep step;

  static const _imageSize = 0.65;
  static const _borderRadius = 16.0;
  static const _textBackgroundOpacity = 0.75;
  static const _textSize = 0.022;

  @override
  State<RecipeStepView> createState() => RecipeStepViewState();
}

class RecipeStepViewState extends State<RecipeStepView> {
  var _isSaying = false;
  static RecipeStepViewState? currentState;
  static int _slideId = 0;

  @override
  void initState() {
    super.initState();
    currentState = this;
  }

  static RecipeStepViewState? getCurrent(){
    return currentState;
  }

  void say() {
    _pronounce();
    setState(() {
      _isSaying = true;
    });
  }

  void stopSaying() {
    RecipeStepView.tts.stop();
    setState(() {
      _isSaying = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    RecipeStepView.tts.stop();
  }

  double _getImageHeight() {
    var timerCoefficient = 1.0;
    if (widget.step.waitTime != 0) {
      timerCoefficient = 0.85;
    }
    if (widget.step.description.length >= 140) {
      return Config.pageHeight(context) *
          RecipeStepView._imageSize *
          0.9 *
          timerCoefficient;
    }
    return Config.pageHeight(context) *
        RecipeStepView._imageSize *
        timerCoefficient;
  }

  Widget _buildTimer() {
    if (widget.step.waitTime == 0) {
      return Container();
    }
    int timerId = widget.slideId + widget.recipe.id * 100;
    return TimerView(
      key: Key("$timerId"),
      waitTimeMins: widget.step.waitTime,
      id: timerId,
      alarmText: "${widget.recipe.name}: шаг ${widget.slideId - 1}",
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isSaying && _slideId != widget.slideId) {
      _pronounce();
    }
    _slideId = widget.slideId;
    return Container(
        padding: const EdgeInsets.all(Config.padding),
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, Config.margin * 2, 0, 0),
                  height: _getImageHeight(),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(RecipeStepView._borderRadius),
                    child: Image(
                      image: AssetImage(widget.step.imgUrl),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.symmetric(
                        vertical: Config.margin, horizontal: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87
                              .withOpacity(RecipeStepView._textBackgroundOpacity),
                          borderRadius:
                              BorderRadius.circular(RecipeStepView._borderRadius)),
                      // height: 120,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(Config.padding),
                      child: Text(
                        widget.step.description,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: Config.pageHeight(context) *
                                RecipeStepView._textSize,
                            color: Colors.white),
                      ),
                    )
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, Config.margin),
                  child: _buildTimer(),
                )
              ],
            ),
            Container(
              color: Config.backColors[widget.recipe.id % Config.backColors.length],
              height: 55,
              alignment: Alignment.topCenter,
              child: HeaderButtonsPanel.buildButton(context, _buildSayIcon(),
                  !_isSaying ? backColor : backColor.withOpacity(0.6)),
            ),
          ],
        ));
  }

  static const backColor = Colors.white;
  static const iconColor = Colors.black87;

  void _continueListening() {
    HeaderButtonsPanelState.getCurrent()?.startListening();
  }

  void _pronounce() {
    HeaderButtonsPanelState.getCurrent()?.stopListening();
    RecipeStepView.tts.setCompletionHandler(_continueListening);
    RecipeStepView.tts.setPauseHandler(_continueListening);
    RecipeStepView.tts.setCancelHandler(_continueListening);
    RecipeStepView.tts.speak(widget.step.description);
  }

  IconButton _buildSayIcon() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isSaying = !_isSaying;
          });
          if (_isSaying) {
            _pronounce();
          } else {
            RecipeStepView.tts.stop();
          }
        },
        icon: _isSaying
            ? const Icon(
                Icons.pause,
                color: iconColor,
              )
            : const Icon(
                Icons.play_arrow,
                color: iconColor,
              )
    );
  }
}
