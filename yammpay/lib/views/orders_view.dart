import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/providers/auth_provider.dart';
import 'package:yammpay/providers/order_provider.dart';
import 'package:yammpay/views/order_details_widget.dart';

import '../config/themes/constants.dart';
import 'widget/addspace_widget.dart';
import 'widget/page_layout_widget.dart';
import 'widget/page_title_widget.dart';
import 'loggedoff_view.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);
  static const String id = '/OrdersScreen';

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    var _userProvider = Provider.of<AuthProvider>(context);
    var _orderProvider = Provider.of<OrderProvider>(context);
    return DefaultTabController(
      length: 2,
      child: PageLayout(
        child: _userProvider.isLoggedIn
            ? Column(children: [
                const PageTitle(title: "Orders"),
                Padding(
                  padding: EdgeInsets.all(PADDING),
                  child: Container(
                    decoration: BoxDecoration(
                      color: COLOR_GREY,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                          labelColor: COLOR_WHITE,
                          labelStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'IBMPlexSansArabic'),
                          unselectedLabelColor: COLOR_PURPLE,
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'IBMPlexSansArabic'),
                          indicator: BoxDecoration(
                            color: COLOR_PURPLE,
                            border: Border.all(
                                color: COLOR_PURPLE.withOpacity(0.4), width: 3),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          tabs: const [
                            Tab(
                              text: "Pending",
                            ),
                            Tab(
                              text: "Completed",
                            ),
                          ]),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                     _orderProvider.pastOrders.isEmpty
                        ? Center(
                            child: Text(
                            'You Do not Have Any Orders Yet :(',
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                          ))
                        : PendingOrdersList(),
                    CompletedOrdersList(),
                  ]),
                ),
                addVerticalSpace(10.h),
              ])
            : LoggedOffScreen(),
      ),
    );
  }
}
