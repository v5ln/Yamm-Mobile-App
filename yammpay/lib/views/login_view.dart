import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/models/flags.dart';
import 'package:yammpay/providers/auth_provider.dart';
import 'package:yammpay/views/otp_view.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:yammpay/views/widget/button_widget.dart';
import 'package:yammpay/views/widget/loading_widget.dart';
import 'package:yammpay/views/widget/page_layout_widget.dart';
import 'package:yammpay/views/widget/page_titleandsub_widget.dart';
import 'package:yammpay/views/widget/snackbar_widget.dart';

bool allowNext = false;
TextEditingController _phoneNumberController = new TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = '/PhoneNumberScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedFlag = Flags().flags[0];
  String phoneNumber = '';

  Future<void> _sendOTP() async {
    var _userProvider = Provider.of<AuthProvider>(context, listen: false);
    //* Save the phone number to send the OTP to it
    phoneNumber =
        selectedFlag.substring(5) + _phoneNumberController.text.trim();

    //* Call the method to handle the responses (Show snackbar...etc)
    await _userProvider.postSendOTP(phoneNumber);

    //* Show the error message(s) if there is any
    if (_userProvider.hasError) {
      YammSnackBar.show(body: _userProvider.errorMessage);
    } else
      Get.to(()=>OTPScreen());
      YammSnackBar.show(body: 'Your otp is: ' + _userProvider.otp, type: MessageType.succses);
    // showActionSnackBar(context, ' Your otp is: ' + _userProvider.otp);
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _phoneNumberController.addListener(() {
      final isButtonActive = _phoneNumberController.text.length == 9;
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitleAndSubtitle(
                    // title: Text("translation(context).enter_your_number_title",
                    title: Text("Enter your number",
                        style: kPageTitleStyle),
                    subtitle: Text(
                        // "translation(context).enter_your_number_subtitle",
                        "Enter your number to send an OTP verfication code",
                        style: kSubtitleStyle),
                  ),
                  addVerticalSpace(32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.ltr,
                    children: [
                      ChooseFlag(),
                      const PhoneNumberLoginTextField(),
                    ],
                  ),
                  addVerticalSpace(40.h),
                  allowNext
                      ? ButtonWidgetPurple(
                          text: "Next",
                          // text: translation(context).next_title,
                          onClicked: (() async => _sendOTP()))
                      : ButtonWidgetGrey(
                          // text: translation(context).next_title,
                          text: "Next",
                        ),
                ],
              ),
            ),
    );
  }

  SizedBox ChooseFlag() {
    return SizedBox(
      width: 105.w,
      height: 60.h,
      child: DropdownButtonFormField<String>(
        isDense: false,
        itemHeight: 60,
        isExpanded: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(45.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 3.0),
            borderRadius: BorderRadius.circular(45.0),
          ),
        ),
        value: Flags().flags[0],
        items: Flags()
            .flags
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 14.5.sp),
                )))
            .toList(),
        onChanged: (item) => setState(() {
          selectedFlag = item!;
        }),
      ),
    );
  }
}

class PhoneNumberLoginTextField extends StatelessWidget {
  const PhoneNumberLoginTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 56,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.justify,
        inputFormatters: [
          LengthLimitingTextInputFormatter(9),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 9) {
            allowNext = true;
            FocusScope.of(context).unfocus();
          }
        },
        decoration: InputDecoration(
          hintText: '5xxxxxxxx',
          hintTextDirection: TextDirection.ltr,
          hintStyle: TextStyle(color: COLOR_BLACK.withOpacity(0.2)),
          contentPadding: const EdgeInsets.all(20.0),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: const BorderSide(color: COLOR_PURPLE, width: 3),
          ),
          filled: false,
          errorStyle: TextStyle(
              color: COLOR_RED,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp),
        ),
      ),
    );
  }
}
