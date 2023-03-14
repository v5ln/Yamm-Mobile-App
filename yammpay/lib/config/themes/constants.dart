// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const COLOR_PURPLE = Color(0xFF9E6CFF);
const COLOR_PURPLE_OPCITY = Color(0xFFF8F4FF);
const COLOR_BLACK = Color(0xFF30302F);
const COLOR_GREY = Color(0xFFEEEEEE);
const COLOR_WHITE = Color(0xFFFFFFFF);
const COLOR_RED = Colors.redAccent;

// ! MAY NOT BE USED
const COLOR_YELLOW = Color(0xFFFFCD2E);
const COLOR_PINK = Color(0xFFFF8389);
const COLOR_BLUE = Color(0xff8FB2EA);
const COLOR_GREEN = Color(0xFF7ECEBF);

final PADDING = 25.h;
final SIDE_PADDING = EdgeInsets.symmetric(horizontal: PADDING.w);

MaterialColor primaryColors() {
  return const MaterialColor(0xFF9E6CFF, {
    50: COLOR_PURPLE,
    100: COLOR_PURPLE,
    200: COLOR_PURPLE,
    300: COLOR_PURPLE,
    400: COLOR_PURPLE,
    500: COLOR_PURPLE,
    600: COLOR_PURPLE,
    700: COLOR_PURPLE,
    800: COLOR_PURPLE,
    900: COLOR_PURPLE,
  });
}

TextStyle kTitleStyle = TextStyle(
    color: COLOR_WHITE,
    fontSize: 36.sp,
    height: 1.3,
    fontWeight: FontWeight.w900);

TextStyle kLangStyle = TextStyle(
    color: COLOR_WHITE.withOpacity(0.8),
    fontSize: 16.sp,
    fontWeight: FontWeight.bold);

TextStyle kSubStyle = TextStyle(
  color: COLOR_WHITE,
  fontSize: 18.sp,
  height: 1.3,
);
TextStyle kSubtitleStyle = TextStyle(
  color: Colors.grey,
);

TextStyle kPageTitleStyle = TextStyle(
  color: COLOR_BLACK,
  fontSize: 25.sp,
  fontWeight: FontWeight.w700,
);
TextStyle kItemReturnedStatusStyle = TextStyle(
  color: COLOR_BLACK,
  fontWeight: FontWeight.bold,
  fontSize: 14.sp,
);

TextStyle kSettingItemStyle = TextStyle(
  color: COLOR_BLACK,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
);
TextStyle kAddressTitleStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
);

TextStyle kAddressContentStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp);

TextStyle kContactStyle = TextStyle(
  color: COLOR_BLACK,
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
);

InputDecoration kInputDecorationStyle = InputDecoration(
  hintText: 'Yo',
  hintStyle: TextStyle(color: COLOR_PURPLE),
  border: InputBorder.none,
  prefixIcon: Icon(
    Icons.numbers,
    color: COLOR_PURPLE,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: COLOR_WHITE),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: COLOR_WHITE,
    ),
  ),
  filled: true,
  fillColor: COLOR_WHITE,
);

class kAppBarStyle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const kAppBarStyle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.h,
      iconTheme: IconThemeData(color: COLOR_BLACK),
      title: Text(title, style: kPageTitleStyle),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
