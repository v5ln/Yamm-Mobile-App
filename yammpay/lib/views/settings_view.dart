import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/providers/auth_provider.dart';
import 'package:yammpay/views/card_view.dart';
import 'package:yammpay/views/loggedoff_view.dart';
import 'package:yammpay/views/widget/page_title_widget.dart';
import 'package:yammpay/views/widget/settings_widget.dart';

import '../config/themes/constants.dart';
import 'widget/page_layout_widget.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String id = '/SettingsScreen';

  @override
  Widget build(BuildContext context) {
    var _userProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: COLOR_BLACK,
      body: PageLayout(
        child: _userProvider.isLoggedIn
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PageTitle(title: translation(context).settings_title),
                  PageTitle(title:"settings_title"),
                  Padding(
                    padding: EdgeInsets.all(PADDING),
                    child: Column(
                      children: [
                        SettingItem(
                            // title: translation(context).email_field,
                            title: "Email",
                            icon: const Icon(Icons.email),
                            onClick: () => null
                            // Navigator.pushNamed(
                            //     context, ChangeEmailScreen.id)
                                ),
                        SettingItem(
                            // title: translation(context).mycards_title,
                            title: "My Cards",
                            icon: const Icon(Icons.credit_card),
                            onClick: () =>
                                Get.to(()=> MyCardsScreen())),
                        SettingItem(
                            // title: translation(context).myaddresses_title,
                            title: "My Addresses",
                            icon: const Icon(Icons.home_filled),
                            onClick: () =>null
                            //  Navigator.pushNamed(
                            //     context, MyAdressesScren.id)
                                ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // addVerticalSpace(8.h),
                  TermsCard(
                    // title: translation(context).termsandconditions_title,
                    title:"Terms and Conditions",
                    icon: const Icon(Icons.shield_outlined),
                    ontap: () =>null
                        // Navigator.pushNamed(context, TermsAndConditions.id),
                  ),
                  TermsCard(
                    // title: translation(context).faq_title,
                    title: "FAQ",
                    icon: const Icon(Icons.question_answer_outlined),
                    ontap: () => null
                    // Navigator.pushNamed(context, FAQScreen.id),
                  ),
                  TermsCard(
                    // title: translation(context).privacy_title,
                    title: "Privacy Pollicy",
                    icon: const Icon(Icons.privacy_tip_outlined),
                  ),
                  Padding(
                    padding: EdgeInsets.all(PADDING),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Text(translation(context).contactus_title,
                        Text("Contact Us",
                            style: kContactStyle),
                        // Text(translation(context).whosus_title,
                        Text("Who's Yamm?",
                            style: kContactStyle),
                        // Text(translation(context).aboutus_title,
                        Text("About Us",
                            style: kContactStyle),
                      ],
                    ),
                  ),
                ],
              )
            : LoggedOffScreen(),
      ),
    );
  }
}
