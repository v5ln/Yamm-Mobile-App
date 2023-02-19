import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/providers/data_selection_provider.dart';

import '../navbar_view.dart';
import 'addspace_widget.dart';
import 'button_widget.dart';

Future<dynamic> MethodForDialog(BuildContext context) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 420.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: COLOR_WHITE),
              padding: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildImage(
                        'https://assets3.lottiefiles.com/packages/lf20_djwnoxew.json',
                        250),
                    Spacer(),
                    Text(
                      'YOU ARE DONE!',
                      style: TextStyle(
                          color: COLOR_PINK,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '🥳🎉',
                      style: TextStyle(fontSize: 28),
                    ),
                    addVerticalSpace(4.h),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Your total amount after returning ',
                          style: kSettingItemStyle,
                        ),
                        TextSpan(
                          text:
                              '${Provider.of<DataSelection>(context, listen: false).items.length}',
                          style: kSettingItemStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' items is ',
                          style: kSettingItemStyle,
                        ),
                        TextSpan(
                          text:
                              '${Provider.of<DataSelection>(context, listen: false).total.toStringAsFixed(2)} R.S.',
                          style: kSettingItemStyle.copyWith(
                              fontWeight: FontWeight.bold, color: COLOR_GREEN),
                        ),
                        TextSpan(
                          text: ' and you will be refunded shortly! ',
                          style: kSettingItemStyle,
                        ),
                      ]),
                    ),
                    Spacer(),
                    Text(
                      '* NOTE: You have to return the items within 24 hours to prevent getting a fine',
                      style: TextStyle(
                        color: COLOR_RED,
                        fontStyle: FontStyle.italic,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ButtonWidgetPurple(
                          text: 'Done',
                          onClicked: () {
                            Provider.of<DataSelection>(context, listen: false)
                                .items
                                .clear();
                            Provider.of<DataSelection>(context, listen: false)
                                .total = 0;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => NavHolderScreen()),
                                (Route<dynamic> route) => false);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Widget buildImage(String path, double width) =>
    Center(child: Lottie.network(path, width: width));
