import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yammpay/config/themes/constants.dart';

enum MessageType { error, succses, warining, info }

class YammSnackBar {
  static void show(
      {String header = "Try Again",
      String body = "Somthing went wrong, please try again",
      MessageType type = MessageType.error}) {
    switch (type) {
      case MessageType.error:
        Get.snackbar(
          borderColor: COLOR_PURPLE_OPCITY,
          borderWidth: 2,
          colorText: COLOR_PINK,
          backgroundColor: COLOR_WHITE,
          header,
          body,
          duration: const Duration(seconds: 5),
          isDismissible: true,
          icon: const Icon(Icons.error, color: COLOR_RED),
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeInOutCirc,
          reverseAnimationCurve: Curves.easeInOutCirc,
        );

        break;
      case MessageType.succses:
        header = "Done!";

        Get.snackbar(
          borderColor: COLOR_PURPLE_OPCITY,
          borderWidth: 2,
          colorText: COLOR_GREEN,
          backgroundColor: COLOR_WHITE,
          header,
          body,
          duration: const Duration(seconds: 5),
          isDismissible: true,
          icon: const Icon(Icons.check, color: COLOR_GREEN),
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeInOutCirc,
          reverseAnimationCurve: Curves.easeInOutCirc,
        );

        break;
      case MessageType.warining:
        header = "Warning!";
        Get.snackbar(
          borderColor: COLOR_PURPLE_OPCITY,
          borderWidth: 2,
          colorText: COLOR_YELLOW,
          backgroundColor: COLOR_WHITE,
          header,
          body,
          duration: const Duration(seconds: 5),
          isDismissible: true,
          icon: const Icon(Icons.warning, color: COLOR_YELLOW),
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeInOutCirc,
          reverseAnimationCurve: Curves.easeInOutCirc,
        );
        break;
        case MessageType.info:
         header = "Info";
        Get.snackbar(
          borderColor: COLOR_PURPLE_OPCITY,
          borderWidth: 2,
          colorText: COLOR_GREY,
          backgroundColor: COLOR_WHITE,
          header,
          body,
          duration: const Duration(seconds: 5),
          isDismissible: true,
          icon: const Icon(Icons.message, color: COLOR_GREY),
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeInOutCirc,
          reverseAnimationCurve: Curves.easeInOutCirc);
        break;


      default:
    }
  }
}
