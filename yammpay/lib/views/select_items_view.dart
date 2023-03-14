// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:yammpay/providers/order_provider.dart';
// import 'package:yammpay/screens/choose_payment_screen.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/views/select_payment_view.dart';
import 'package:yammpay/views/widget/Dialog_method.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:yammpay/views/widget/button_widget.dart';
import 'package:yammpay/views/widget/page_layout_widget.dart';
import 'package:yammpay/views/widget/page_title_widget.dart';
import 'package:yammpay/views/widget/select_item_widget.dart';
// import 'package:yammpay/views/widget/select_item_card.dart';

class SelectItemsScreen extends StatefulWidget {
  const SelectItemsScreen({Key? key}) : super(key: key);
  static const String id = '/SelectItemsScreen';

  @override
  State<SelectItemsScreen> createState() => _SelectItemsScreenState();
}

class _SelectItemsScreenState extends State<SelectItemsScreen> {
  _SelectItemsScreenState();

  void validateSelectedItems() {
    var _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    // DialogMethod(context);
    _orderProvider.items.isEmpty
        ? DialogMethod(context)
        : Get.to(() => SelectPaymentScreen());
    // : Navigator.pushNamed(context, SelectPaymentScreen.id);
    // _orderProvider.addItemsId();
  }

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);

    return PageLayout(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PageTitle(title: translation(context).select_items_title),
        PageTitle(title: "Item Details"),
        addVerticalSpace(16.h),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              shrinkWrap: true,
              children: [
                const StoreInfoWidget(),
                addVerticalSpace(16.h),
                const OrderNumberWidget(),
                addVerticalSpace(24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  child: Text(
                    // translation(context).choose_items_title,
                    "Select items to return",
                    style: kSettingItemStyle.copyWith(fontSize: 18.sp),
                  ),
                ),
                // addVerticalSpace(8.h),
                // if (_orderProvider.items.length != 0) ...[
                //   Consumer<OrderProvider>(
                //     builder: (context, order_provider, child) =>
                //         NumberOfItemsWidget(orderProvider: _orderProvider),
                //   ),
                // ],
                addVerticalSpace(8.h),
                MediaQuery.removePadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _orderProvider.order.items.length,
                    itemBuilder: (context, index) {
                      return SelectItemCard(
                        title: _orderProvider.order.items[index].title,
                        image: _orderProvider.order.items[index].image.url,
                        isRefundable:
                            _orderProvider.order.items[index].isRefundable,
                        price: _orderProvider.order.items[index].price,
                        variantTitle:
                            _orderProvider.order.items[index].variantTitle,
                        id: _orderProvider.order.items[index].id,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return addVerticalSpace(12.h);
                    },
                  ),
                ),
                addVerticalSpace(16.sp),
                Padding(
                  padding: SIDE_PADDING,
                  child: ButtonWidgetPurple(
                      text: 'Continue',
                      onClicked: () {
                        validateSelectedItems();
                      }),
                ),
              ],
            ),
          ),
        ),
        //  addVerticalSpace(10.h),
      ],
    ));
  }

  Future<dynamic> DialogMethod(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return const Center(
            child: Material(
                type: MaterialType.transparency, child: OverviewEmpty()),
          );
        });
  }
}

class NumberOfItemsWidget extends StatelessWidget {
  const NumberOfItemsWidget({
    Key? key,
    required OrderProvider orderProvider,
  })  : _orderProvider = orderProvider,
        super(key: key);

  final OrderProvider _orderProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: _orderProvider.items.length.toString(),
            style: TextStyle(
                color: COLOR_PURPLE,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp
                //decoration: TextDecoration.underline,
                ),
          ),
          TextSpan(
            text: " Items selected",
            style: TextStyle(
                color: COLOR_PURPLE,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
          ),
        ]),
      ),
    );
  }
}

class OrderNumberWidget extends StatelessWidget {
  const OrderNumberWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var order_number =
        Provider.of<OrderProvider>(context).order.orderId.toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Number: ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: COLOR_PURPLE_OPCITY,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '#' + order_number,
              style: TextStyle(
                color: COLOR_PURPLE,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StoreInfoWidget extends StatelessWidget {
  const StoreInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 62.w,
            child: Image.network(
              _orderProvider.chosenStore.logo,
              fit: BoxFit.fill,
            ),
          ),
          addHorizontalSpace(16.w),
          Text(
            _orderProvider.chosenStore.name,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class OverviewEmpty extends StatelessWidget {
  const OverviewEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 350.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: COLOR_WHITE),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          buildImage(
              'https://assets9.lottiefiles.com/private_files/lf30_cgfdhxgx.json',
              250),
          Text(
            '🤕 Choose items to be refunded!',
            style: kSettingItemStyle,
          ),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Back',
                style: TextStyle(fontSize: 18.sp),
              ))
        ],
      ),
    );
  }
}
