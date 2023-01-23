import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/themes/constants.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
  }) : super();

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(COLOR_BLACK),
          backgroundColor: MaterialStateProperty.all<Color>(COLOR_WHITE),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: COLOR_WHITE,
                width: 2.0.w,
              ),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: COLOR_PURPLE,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
      );
}

class ButtonWidgetPurple extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidgetPurple({
    required this.text,
    required this.onClicked,
  }) : super();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 55.h,
        child: ElevatedButton(
          onPressed: onClicked,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(COLOR_PURPLE),
            backgroundColor: MaterialStateProperty.all<Color>(COLOR_PURPLE),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
            child: Text(
              text,
              style: TextStyle(
                  color: COLOR_WHITE,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );
}

class ButtonWidgetGrey extends StatelessWidget {
  final String text;

  const ButtonWidgetGrey({
    required this.text,
  }) : super();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 55.h,
        child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(COLOR_WHITE),
            // backgroundColor: MaterialStateProperty.all<Color>(COLOR_WHITE),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
            child: Text(
              text,
              style: TextStyle(
                  color: COLOR_BLACK,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );
}

class BuildButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color? buttonnColor;
  final Color? textColor;

  const BuildButton({
    required this.text,
    required this.onClicked,
    this.buttonnColor = COLOR_PURPLE,
    this.textColor = COLOR_WHITE,
  }) : super();

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(buttonnColor!),
          backgroundColor: MaterialStateProperty.all<Color>(buttonnColor!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
        ),
      );
}
