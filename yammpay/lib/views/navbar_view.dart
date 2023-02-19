// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/providers/auth_provider.dart';
import 'package:yammpay/providers/bank_provider.dart';
import 'package:yammpay/views/settings_view.dart';

import '../config/themes/constants.dart';
import '../providers/order_provider.dart';
import 'form_view.dart';
import 'orders_view.dart';

class NavHolderScreen extends StatefulWidget {
  final int? index;
  const NavHolderScreen({Key? key, this.index = 1}) : super(key: key);
  static const String id = '/';

  @override
  State<NavHolderScreen> createState() => _NavHolderScreenState(index!);
}

class _NavHolderScreenState extends State<NavHolderScreen> {
  int index;
  _NavHolderScreenState(this.index);
  final screens = [OrderView(), FormScreen(), SettingsScreen()];

  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void initState() {
    // * Get user device token
    // _fcm.getToken().then((token) {
    //   var _userProvider = Provider.of<AuthProvider>(context, listen: false);
    //   _userProvider.checkLogin();
    // });
    var _userProvider = Provider.of<AuthProvider>(context, listen: false);
      _userProvider.checkLogin();
    getAllUserInfo();
    super.initState();
  }

  void getAllUserInfo() async {
    var _userProvider = Provider.of<AuthProvider>(context, listen: false);
    var _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    //   var _addressProvider = Provider.of<AddressProvider>(context, listen: false);
    var _bankProvider = Provider.of<BankProvider>(context, listen: false);

    //   await _userProvider.getDegitalAgreement();
    //   await _userProvider.getFaqs();
    await _orderProvider.getStores();
    //   await _orderProvider.getPastOrders();
    //   await _addressProvider.getAddresses();
    await _bankProvider.getBankAccounts();
    // await _bankProvider.getBankList();
    //   if (_addressProvider.addresses.isNotEmpty) {
    //     await _addressProvider.getAllCountries();
    //     await _addressProvider.getAllStates();
    //     await _addressProvider.getAllCities();
    //   }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: COLOR_GREY,
          child: SafeArea(
            top: false,
            child: Scaffold(
              extendBody: true,
              backgroundColor: COLOR_PURPLE,
              body: screens[index],
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(top: 10.0.h),
                child: CurvedNavigationBar(
                    //? COLOR OF THE CURVED AREA WHEN YOU SELECT A BUTTON
                    backgroundColor: Colors.transparent,
                    animationDuration: const Duration(milliseconds: 250),
                    //? COLOR OF THE NAV BAR ITSELF
                    color: COLOR_GREY,
                    //? COLOR OF THE SELECTED BUTTON BACKGROUND
                    buttonBackgroundColor: COLOR_GREY,
                    index: index,
                    onTap: (index) => setState(() => this.index = index),
                    items: const [
                      BottomNavigatorItem(
                          iconPath: 'assets/icons/orders-history.svg'),
                      BottomNavigatorItem(iconPath: 'assets/icons/home.svg'),
                      BottomNavigatorItem(
                          iconPath: 'assets/icons/settings.svg'),
                    ]),
              ),
            ),
          ),
        ),
      );
}

class BottomNavigatorItem extends StatelessWidget {
  final String iconPath;
  const BottomNavigatorItem({
    Key? key,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            iconPath,
            color: COLOR_PURPLE,
            height: 30.h,
            width: 30.w,
          ),
        ],
      ),
    );
  }
}
