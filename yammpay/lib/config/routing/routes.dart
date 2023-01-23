import 'package:flutter/material.dart';
import 'package:yammpay/views/navbar_view.dart';
// import 'package:yamm_refund/screens/adresses_screen.dart';
// import 'package:yamm_refund/screens/cards_screen.dart';
// import 'package:yamm_refund/screens/choose_address_screen.dart';
// import 'package:yamm_refund/screens/choose_carrier_screen.dart';
// import 'package:yamm_refund/screens/choose_payment_screen.dart';
// import 'package:yamm_refund/screens/degital_agreement.dart';
// import 'package:yamm_refund/screens/email_screen.dart';
// import 'package:yamm_refund/screens/enter_absher_otp_screen.dart';
// import 'package:yamm_refund/screens/enter_absherinfo_screen.dart';
// import 'package:yamm_refund/screens/enter_otp_login_screen.dart';
// import 'package:yamm_refund/screens/enter_phonenumber_login_screen.dart';
// import 'package:yamm_refund/screens/faq_screen.dart';
// import 'package:yamm_refund/screens/form_screen.dart';
// import 'package:yamm_refund/screens/map_screen.dart';
// import 'package:yamm_refund/screens/nav_holder_screen.dart';
// import 'package:yamm_refund/screens/notification_screen.dart';
// import 'package:yamm_refund/screens/order_overview_screen.dart';
// import 'package:yamm_refund/screens/orders_screen.dart';
// import 'package:yamm_refund/screens/pending_orders_screen.dart';
// import 'package:yamm_refund/screens/post_refund_screen.dart';
// import 'package:yamm_refund/screens/select_items_screen.dart';
// import 'package:yamm_refund/screens/settings_screen.dart';
// import 'package:yamm_refund/screens/terms_and_conditions.dart';

Route<dynamic>? routes(routeSettings) {
  switch (routeSettings.name) {
    case "nav":
       return MaterialPageRoute(builder: (context) => const NavHolderScreen());
    default:
  }
  // if (routeSettings.name == NavHolderScreen.id) {
  //   return MaterialPageRoute(builder: (context) => const NavHolderScreen());
  // } else if (routeSettings.name == FormScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const FormScreen());
  // } else if (routeSettings.name == OrderScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const OrderScreen());
  // } else if (routeSettings.name == PendingOrdersScreen.id) {
  //   final orderIndex = routeSettings.arguments as int;
  //   return MaterialPageRoute(
  //       builder: (_) => PendingOrdersScreen(orderIndex: orderIndex));
  // } else if (routeSettings.name == SettingsScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const SettingsScreen());
  // } else if (routeSettings.name == ChangeEmailScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const ChangeEmailScreen());
  // } else if (routeSettings.name == MyCardsScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const MyCardsScreen());
  // } else if (routeSettings.name == MyAdressesScren.id) {
  //   return MaterialPageRoute(builder: (_) => const MyAdressesScren());
  // } else if (routeSettings.name == TermsAndConditions.id) {
  //   return MaterialPageRoute(builder: (_) => const TermsAndConditions());
  // } else if (routeSettings.name == FAQScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const FAQScreen());
  // } else if (routeSettings.name == NotificationsScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const NotificationsScreen());
  // } else if (routeSettings.name == LoginScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const LoginScreen());
  // } else if (routeSettings.name == OTPScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const OTPScreen());
  // } else if (routeSettings.name == AbsherScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const AbsherScreen());
  // } else if (routeSettings.name == MapScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const MapScreen());
  // } else if (routeSettings.name == AbsherOtpScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const AbsherOtpScreen());
  // } else if (routeSettings.name == DegitalAgreementScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const DegitalAgreementScreen());
  // } else if (routeSettings.name == SelectItemsScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const SelectItemsScreen());
  // } else if (routeSettings.name == ChooseCardScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const ChooseCardScreen());
  // } else if (routeSettings.name == ChooseAdressScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const ChooseAdressScreen());
  // } else if (routeSettings.name == ChooseCarrierScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const ChooseCarrierScreen());
  // } else if (routeSettings.name == OrderOverviewScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const OrderOverviewScreen());
  // } else if (routeSettings.name == PostRefundScreen.id) {
  //   return MaterialPageRoute(builder: (_) => const PostRefundScreen());
  // }
  return null;
}
