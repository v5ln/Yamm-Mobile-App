import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:yamm_refund/models/language_constant.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onClick;

  const SettingItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: COLOR_WHITE,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: COLOR_PURPLE),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: COLOR_GREY,
                radius: 30.r,
                child: icon,
              ),
              addHorizontalSpace(15.w),
              Text(
                title,
                style: kSettingItemStyle,
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_right,
                color: COLOR_PURPLE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function()? ontap;

  const TermsCard(
      {Key? key, required this.title, required this.icon, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: COLOR_WHITE.withOpacity(0.5),
            borderRadius: BorderRadius.zero,
            border: const Border.symmetric(
              horizontal: BorderSide.none,
            )),
        child: Row(children: [
          icon,
          addHorizontalSpace(15.w),
          Text(title),
        ]),
      ),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? validate;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;

  const CustomTextForm(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.keyboardType,
      this.controller,
      this.validate = true,
      this.inputFormatters,
      this.onChanged, this.onEditingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: COLOR_BLACK.withOpacity(0.4)),
        border: InputBorder.none,
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: COLOR_PURPLE,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: COLOR_PINK,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: COLOR_PURPLE,
          ),
        ),
        filled: true,
        fillColor: COLOR_WHITE,
      ),
      validator: (value) {
        if (value!.isEmpty && validate!) {
          // return translation(context).forms_error_string;
          return "forms_error_string";
        } else {
          return null;
        }
      },
    );
  }
}
