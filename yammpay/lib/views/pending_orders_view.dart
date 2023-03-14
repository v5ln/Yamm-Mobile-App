import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/providers/order_provider.dart';
import 'package:yammpay/views/order_details.dart';
import 'package:yammpay/views/timer_widget.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:yammpay/views/widget/button_widget.dart';
import 'package:yammpay/views/widget/loading_widget.dart';
import 'package:yammpay/views/widget/page_layout_widget.dart';
import 'package:yammpay/views/widget/page_title_widget.dart';
import 'package:yammpay/views/widget/timeline_widget.dart';

class PendingOrdersScreen extends StatefulWidget {
  final int orderIndex;
  const PendingOrdersScreen({Key? key, required this.orderIndex})
      : super(key: key);
  static const String id = '/PendingOrdersScreen';

  @override
  State<PendingOrdersScreen> createState() =>
      _PendingOrdersScreenState(orderIndex);
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  int orderIndex;
  _PendingOrdersScreenState(this.orderIndex);

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
        body: PageLayout(
      child: _orderProvider.isLoading
          ? const Center(
              child: LoadingSpinner(),
            )
          : MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(children: [
                PageTitle(
                    title: 'Order: ' +
                        _orderProvider.pastOrders[orderIndex]['order_number']),
                ProcessTimelinePage(),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  color: COLOR_WHITE.withOpacity(0.9),
                  child: Column(children: [
                    const TimerWidget(),
                    addVerticalSpace(20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: BuildButton(
                        text: 'Confirm returning the items',
                        onClicked: () {},
                        buttonnColor: COLOR_GREEN,
                      ),
                    ),
                    addVerticalSpace(20.h),
                    const Divider(),
                    Padding(
                      padding: SIDE_PADDING,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OrderDetailInfo(
                            title: 'Store Name',
                            content: _orderProvider.pastOrders[orderIndex]
                                ['store']['name'],
                          ),
                          OrderDetailInfo(
                              title: 'Date of returning',
                              content: _orderProvider.pastOrders[orderIndex]
                                      ['created_at']
                                  .toString()),
                        ],
                      ),
                    ),
                    addVerticalSpace(15.h),
                    Padding(
                      padding: SIDE_PADDING,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          OrderDetailInfo(
                            title: 'Address',
                            content: 'Saudi arabia, Khobar Alrakah, 32857',
                          ),
                          OrderDetailInfo(
                            title: 'Bank Account',
                            content:
                                'Bank Alrajhi, HASSAN ALYOUSEF card end with **8428',
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'TOTAL:',
                            style: kSettingItemStyle,
                          ),
                          Text(
                            'SAR' +
                                _orderProvider.pastOrders[orderIndex]
                                        ['final_amount']
                                    .toString(),
                            style: kSettingItemStyle.copyWith(
                                color: COLOR_GREEN,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ]),
                  ]),
                ),
                addVerticalSpace(12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No. of items: ',
                          style: TextStyle(
                              color: COLOR_BLACK,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600)),
                      Text(
                          _orderProvider.pastOrders[orderIndex]['items'].length
                              .toString(),
                          style: TextStyle(
                              color: COLOR_PURPLE,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Divider(),
                ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemCount:
                        _orderProvider.pastOrders[orderIndex]['items'].length,
                    itemBuilder: ((context, index) {
                      return OrderDetailCard(
                        itemName: _orderProvider.pastOrders[orderIndex]['items']
                            [index]['name'],
                        itemPrice: _orderProvider.pastOrders[orderIndex]
                            ['items'][index]['price'],
                        imgPath: _orderProvider.pastOrders[orderIndex]['items']
                            [index]['images'][0]['src'],
                        status: 3,
                      );
                    }),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    }),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    color: COLOR_WHITE,
                    child: Padding(
                      padding: SIDE_PADDING,
                    ),
                  ),
                )
              ])),
    ));
  }
}

class OrderDetailInfo extends StatelessWidget {
  final String title, content;

  const OrderDetailInfo({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 160.w,
            child: Text(
              title,
              style: TextStyle(
                  color: COLOR_BLACK.withOpacity(0.9),
                  fontWeight: FontWeight.w300),
            )),
        Container(
            width: 160.w,
            child: Text(
              content,
              style: TextStyle(
                  color: COLOR_BLACK,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            )),
      ],
    );
  }
}

void goToTimeline(context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProcessTimelinePage()),
    );
