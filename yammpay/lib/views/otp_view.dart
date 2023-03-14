// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/providers/auth_provider.dart';
import 'package:yammpay/views/navbar_view.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:yammpay/views/widget/button_widget.dart';
import 'package:yammpay/views/widget/loading_widget.dart';
import 'package:yammpay/views/widget/page_layout_widget.dart';
import 'package:yammpay/views/widget/page_titleandsub_widget.dart';
import 'package:yammpay/views/widget/pin_textfield_widget.dart';
import 'package:yammpay/views/widget/snackbar_widget.dart';


class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);
  static const String id = '/LoginScreen';

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

String pin = '';
bool allowNext = false;
TextEditingController pin1 = TextEditingController();
TextEditingController pin2 = TextEditingController();
TextEditingController pin3 = TextEditingController();
TextEditingController pin4 = TextEditingController();

class _OTPScreenState extends State<OTPScreen> {
  Future<void> _verifyOTP() async {
    var _userProvider = Provider.of<AuthProvider>(context, listen: false);
    //*Save the pin number entered
    pin = pin1.text + pin2.text + pin3.text + pin4.text;
    //* Call the method
    await _userProvider.postVerifyOTP(_userProvider.phone_number, pin);
    if (_userProvider.hasError) {
      YammSnackBar.show(body: _userProvider.errorMessage);
    } else if (_userProvider.otpVerified) if (_userProvider.customerExists) {
      await _userProvider.postLogin(_userProvider.phone_number, pin);
      if (_userProvider.status) {
        Get.offAll(()=>NavHolderScreen());
        // Navigator.pushReplacementNamed(context, NavHolderScreen.id);
      }
    } else {
      YammSnackBar.show(type: MessageType.info, body: "A new user!");

      // Navigator.pushNamed(context, AbsherScreen.id);
    }
    else {
      // showActionSnackBar(context, 'The OTP number is wrong!');
      YammSnackBar.show(body: "The OTP number is wrong!");
    }
  }

  void initState() {
    super.initState();
    pin4 = TextEditingController();
    pin4.addListener(() {
      final isButtonActive = pin4.text.isNotEmpty;
      setState((() => allowNext = isButtonActive));
    });
  }

  @override
  Widget build(BuildContext context) {
    var _userProvider = Provider.of<AuthProvider>(context);
    

    return PageLayout(
      child: _userProvider.isLoading
          ? Center(
              child: LoadingSpinner(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: PADDING),
              child: Column(children: [
                PageTitleAndSubtitle(
                  // title: Text(translation(context).otp_verfication_title,
                  title: Text("OTP Verfication",
                      style: kPageTitleStyle),
                  subtitle: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          // text: translation(context).otp_verfication_subtitle,
                          // text: "You have to enter an OTP code we sent via SMS to your phone number ${_userProvider.phone_number}",
                          text: "You have to enter an OTP code we sent via SMS to this phone number:",
                          style: kSubtitleStyle),
                      TextSpan(
                        text: _userProvider.phone_number,
                        recognizer: TapGestureRecognizer()..onTap = (() {}),
                        style: const TextStyle(
                          color: COLOR_PURPLE,
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
                  ),
                ),
                addVerticalSpace(20.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.ltr,
                    children: [
                      PinTextField(pin: pin1, hintText: ','),
                      PinTextField(pin: pin2),
                      PinTextField(pin: pin3),
                      PinTextField(pin: pin4),

                    ]),
                addVerticalSpace(10.h),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend code?',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.sp),
                    )),
                allowNext
                    ? ButtonWidgetPurple(
                        // text: translation(context).next_title,
                        text: "Next",
                        onClicked: () {
                          _verifyOTP();
                          pin1.clear();
                          pin2.clear();
                          pin3.clear();
                          pin4.clear();

                        })
                    // : ButtonWidgetGrey(text: translation(context).next_title),
                    : ButtonWidgetGrey(text: "Next"),
              ]),
            ),
    );
  }
}
