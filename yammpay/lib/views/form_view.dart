import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/providers/auth_provider.dart';
import 'package:yammpay/providers/order_provider.dart';
import 'package:yammpay/views/login_view.dart';
import 'package:yammpay/views/select_items_view.dart';
import 'package:yammpay/views/widget/snackbar_widget.dart';

import '../config/themes/constants.dart';
import '../models/merchant.dart';
import 'widget/HomePage_widgets.dart';
import 'widget/addspace_widget.dart';
import 'widget/button_widget.dart';

String selectedStoreId = "";
String selectedCountry = "+966";

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);
  static const String id = '/formscreen';
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _orderIdController = TextEditingController();
  final _phoneNumberContoller = TextEditingController();
  final _emailContoller = TextEditingController();

  Future<void> _checkOrders() async {
    var _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    await _orderProvider.postCheckOrder(_orderIdController.text,
        email: _emailContoller.text,
        phone_number: selectedCountry + _phoneNumberContoller.text);
    if (_orderProvider.hasError) {
      YammSnackBar.show(header: "Try Again", body: _orderProvider.errorMessage);
      // showActionSnackBar(context, _orderProvider.errorMessage);
    } else {
      _orderProvider.order_number = _orderIdController.text;
      // _orderProvider.store_id = selectedStoreId;
      _orderProvider.items.clear();
      _orderProvider.itemsId.clear();
      Get.to(() => SelectItemsScreen());
      // Navigator.pushNamed(context, SelectItemsScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _userProvider = Provider.of<AuthProvider>(context);
    var _orderProvider = Provider.of<OrderProvider>(context);

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Color(0xffBC9AFF),
      body: false
          ? const Center(child: null)
          : Container(
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.1,
                  0.9,
                  1.3,
                ],
                colors: [
                  COLOR_PURPLE,
                  COLOR_PINK,
                  COLOR_YELLOW,
                ],
              )),
              child: SafeArea(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      AppBarFormPageCustom(_userProvider,context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: PADDING.w, vertical: 20.h),
                        child: const Divider(thickness: 1, color: COLOR_WHITE),
                      ),
                      Padding(
                        padding: SIDE_PADDING,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                "The fastest way to get your refund from the stores!",
                                style: kTitleStyle,
                              ),
                            ),
                            addVerticalSpace(5.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: SizedBox(
                                width: 180.w,
                                child: Text(
                                  "Apply for a Refund",
                                  style: kSubStyle,
                                ),
                              ),
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  addVerticalSpace(40.h),
                                  const StoresDropDowmMenu(),
                                  addVerticalSpace(10.h),
                                  OrderIdTextForm(
                                    controller: _orderIdController,
                                  ),
                                  addVerticalSpace(10.h),
                                  _orderProvider.method == "email"
                                      ? EmailTextForm(
                                          controller: _emailContoller,
                                        )
                                      : PhoneTextForm(
                                          controller: _phoneNumberContoller,
                                        ),
                                  addVerticalSpace(15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 250.w,
                                        height: 45.h,
                                        child: ButtonWidget(
                                            text: "Continue",
                                            onClicked: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                _checkOrders();
                                              }
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Row AppBarFormPageCustom(AuthProvider _userProvider,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const LogoWidget(imgPath: 'assets/images/logo_eng2.png'),
        _userProvider.isLoggedIn
            ? IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/logout.svg',
                  color: COLOR_WHITE,
                ),
                onPressed: ()=>_userProvider.LogOff(),
              )
            : Expanded(
                child: IconButton(
                  icon: Text(
                    "Login",
                    style: kLangStyle,
                  ),
                  onPressed: () =>
                      // Navigator.pushNamed(context, "LoginScreen.id"),
                      Get.to(()=>LoginScreen())
                ),
              ),
        if (false)
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/notification.svg',
              color: COLOR_WHITE,
            ),
            onPressed: null,
            // () =>
            //     Navigator.pushNamed(context, NotificationsScreen.id),
          ),
        const ChangeLangWidget(),
      ],
    );
  }
}

class StoresDropDowmMenu extends StatelessWidget {
  const StoresDropDowmMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);
    final List<String> items =
        _orderProvider.stores.map((store) => store.name).toList();
    return Theme(
      data: ThemeData(
          textTheme: TextTheme(subtitle1: TextStyle(color: COLOR_PURPLE))),
      child: DropdownSearch(
        mode: Mode.DIALOG,
        items: items,
        showSearchBox: true,
        onChanged: (value) {
          _orderProvider.chosenStore = _orderProvider.stores
              .firstWhere((element) => element.name == value);
          _orderProvider.switchVerfiyMethod();
        },
        showSelectedItems: true,
        selectedItem: _orderProvider.selectedStoreName == ""
            ? "Stores"
            : _orderProvider.selectedStoreName,
        dropdownSearchDecoration: InputDecoration(
          hintText: "Stores",
          hintStyle: const TextStyle(color: COLOR_PURPLE),
          prefixIcon: const Icon(
            Icons.store,
            color: COLOR_PURPLE,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: COLOR_WHITE),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: COLOR_WHITE),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: COLOR_PINK, width: 3),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: COLOR_PURPLE),
          ),
          filled: true,
          fillColor: COLOR_WHITE,
          errorStyle: TextStyle(
              color: COLOR_YELLOW,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp),
        ),
        searchFieldProps: const TextFieldProps(
          cursorColor: COLOR_PURPLE,
        ),
        validator: (String? item) {
          if (item == null) {
            return "Please select a store";
          } else {
            return null;
          }
        },
      ),
    );
  }
}

class OrderIdTextForm extends StatelessWidget {
  final TextEditingController controller;
  const OrderIdTextForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Order Number",
        hintStyle: const TextStyle(color: COLOR_PURPLE),
        border: InputBorder.none,
        prefixIcon: const Icon(
          Icons.numbers,
          color: COLOR_PURPLE,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: COLOR_WHITE),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: COLOR_WHITE,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: COLOR_PINK, width: 3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: COLOR_WHITE),
        ),
        filled: true,
        fillColor: COLOR_WHITE,
        errorStyle: TextStyle(
            color: COLOR_YELLOW,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter order number";
        } else {
          return null;
        }
      },
      controller: controller,
    );
  }
}

class PhoneTextForm extends StatefulWidget {
  final TextEditingController controller;

  PhoneTextForm({
    super.key,
    required this.controller,
  });

  @override
  State<PhoneTextForm> createState() => _PhoneTextFormState();
}

class _PhoneTextFormState extends State<PhoneTextForm> {
  var selectedDropDownValue = "🇸🇦 +966";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 55.h,
          decoration: BoxDecoration(
            color: COLOR_WHITE,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: DropdownButton(
            style: const TextStyle(color: COLOR_PURPLE),
            dropdownColor: COLOR_WHITE,
            // focusColor: COLOR_RED,
            // iconEnabledColor: COLOR_RED,
            underline: Text(""),

            items: <String>['🇸🇦 +966', '🇦🇪 +972'].map((name) {
              return DropdownMenuItem<String>(
                value: name,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name.removeAllWhitespace),
                ),
              );
            }).toList(),
            onChanged: ((newValue) {
              setState(() {
                selectedDropDownValue = newValue!;
              });
            }),

            value: selectedDropDownValue,
            isExpanded: false,
          ),
        ),
        addHorizontalSpace(15),
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your phone number";
              } else if (!value!.isNumericOnly) {
                return "Only numbers allowed";
              } else if (value.length != 9) {
                return "Number should be 9 figures";
              } else {
                return null;
              }
            },
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Phone Number",
              hintStyle: const TextStyle(color: COLOR_PURPLE),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.phone,
                color: COLOR_PURPLE,
              ),
              suffixIcon: Tooltip(
                message: 'Enter the same phone number used for this order',
                triggerMode: TooltipTriggerMode.tap,
                showDuration: const Duration(seconds: 4),
                textStyle: TextStyle(
                  color: COLOR_PINK,
                  fontSize: 18.sp,
                ),
                decoration: const BoxDecoration(
                  color: COLOR_WHITE,
                ),
                verticalOffset: 35,
                child: Transform.scale(
                  scale: 0.65,
                  child: SvgPicture.asset(
                    'assets/icons/question.svg',
                    width: 16.w,
                    color: COLOR_PURPLE,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: COLOR_WHITE),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: COLOR_WHITE),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: COLOR_PINK, width: 3),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: COLOR_WHITE),
              ),
              filled: true,
              fillColor: COLOR_WHITE,
            ),
          ),
        ),
      ],
    );
  }
}

class EmailTextForm extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: const TextStyle(color: COLOR_PURPLE),
        border: InputBorder.none,
        prefixIcon: const Icon(
          Icons.email_sharp,
          color: COLOR_PURPLE,
        ),
        suffixIcon: Tooltip(
          message: 'Enter the same email used for this order',
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 4),
          textStyle: TextStyle(
            color: COLOR_PINK,
            fontSize: 18.sp,
          ),
          decoration: const BoxDecoration(
            color: COLOR_WHITE,
          ),
          verticalOffset: 35,
          child: Transform.scale(
            scale: 0.65,
            child: SvgPicture.asset(
              'assets/icons/question.svg',
              width: 16.w,
              color: COLOR_PURPLE,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: COLOR_WHITE),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: COLOR_WHITE),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: COLOR_PINK, width: 3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: COLOR_WHITE),
        ),
        filled: true,
        fillColor: COLOR_WHITE,
      ),
    );
  }
}
