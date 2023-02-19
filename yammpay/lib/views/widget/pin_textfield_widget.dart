import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/providers/auth_provider.dart';

class PinTextField extends StatelessWidget {
  const PinTextField({
    Key? key,
    required this.pin,
    this.hintText = '',
  }) : super(key: key);

  final TextEditingController pin;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    var _userProvider = Provider.of<AuthProvider>(context);
    bool isEnglish = _userProvider.appLang == 'en';
    return SizedBox(
      height: 50.h,
      width: 50.w,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        controller: pin,
        onChanged: ((value) {
          if (value.length == 1) {
            isEnglish
                ? FocusScope.of(context).nextFocus()
                : FocusScope.of(context).previousFocus();
          }
        }),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 8.sp),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: COLOR_PURPLE, width: 3.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
