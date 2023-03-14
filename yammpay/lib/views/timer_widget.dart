import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/config/themes/constants.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? countdownTimer;
  Duration myDuration = Duration(hours: 24);

  @override
  void initState() {
    super.initState();
  }

  // * Timer related methods

  void setCountDown() {
    final reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    if (mounted) setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    if (mounted) setState(() => myDuration = Duration(hours: 24));
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    // final days = strDigits(myDuration.inDays);
    final hours = strDigits(myDuration.inHours.remainder(60));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return GestureDetector(
      onTap: (() => startTimer()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$hours:$minutes:$seconds',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: COLOR_RED, fontSize: 24.sp),
          ),
          Padding(
            padding: SIDE_PADDING,
            child: Text(
              'Return the items to a carrier to avoid the fine!',
              style: TextStyle(
                  color: COLOR_BLACK,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
