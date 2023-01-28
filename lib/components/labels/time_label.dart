import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../pages/constructor/create_recipe_page.dart';
import '../buttons/classic_button.dart';
import '../buttons/delete_button.dart';

class TimeLabel extends StatelessWidget {
  const TimeLabel({super.key, required this.time,
  this.iconSize = 20, this.customFontSize});

  final TimeOfDay time;
  final double iconSize;
  final double? customFontSize;

  static TimeOfDay convertToTOD(int mins) {
    int hours = 0;
    while (mins >= 60) {
      hours++;
      mins -= 60;
    }
    return TimeOfDay(hour: hours, minute: mins);
  }

  static String timeToStr(TimeOfDay time) {
    if (time.hour == 0 && time.minute == 0) return "---";
    if (time.hour == 0) {
      return "${time.minute} мин.";
    }
    if (time.minute == 0) {
      return "${time.hour} ч.";
    }
    return "${time.hour} ч. ${time.minute} мин.";
  }

  double fontSize(BuildContext context) =>
    Config.isDesktop(context) ? 16 : 14;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.timer_outlined,
        color: Config.iconColor,
        size: iconSize,
      ),
      const SizedBox(
        width: Config.margin / 2
      ),
      Container(
        height: iconSize,
        alignment: Alignment.centerLeft,
        child: Text(timeToStr(time),
            style: TextStyle(
                fontFamily: Config.fontFamily,
                fontSize: customFontSize?? fontSize(context),
                color: Config.iconColor)),
      )
    ]);
  }

  static Widget buildSetter(BuildContext context,
      {TimeOfDay? time,
        required String buttonText,
        required String labelText,
        required VoidCallback onSetTap,
        required VoidCallback onDeleteTap}) {
    return time == null
        ? ClassicButton(
      onTap: onSetTap,
      text: buttonText,
        customColor: CreateRecipePage.buttonColor,
      fontSize: CreateRecipePage.generalFontSize(context),
    )
        : Container(
      decoration: BoxDecoration(
          color: CreateRecipePage.buttonColor.withOpacity(.9),
          borderRadius: Config.borderRadiusLarge),
      padding: const EdgeInsets.symmetric(horizontal: Config.padding),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: TextStyle(
                  fontFamily: Config.fontFamily,
                  color: Config.iconColor,
                  fontSize: CreateRecipePage.generalFontSize(context)),
            ),
            SizedBox(
              width: CreateRecipePage.pageWidth(context) * .4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeLabel(time: time),
                  const SizedBox(
                    width: Config.margin / 2,
                  ),
                  DeleteButton(
                      margin: const EdgeInsets.all(Config.margin * .2),
                      onPressed: onDeleteTap)
                ],
              ),
            )
          ]),
    );
  }
}
