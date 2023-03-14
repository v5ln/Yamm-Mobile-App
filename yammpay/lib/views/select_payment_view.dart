import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:yammpay/providers/bank_provider.dart';
import 'package:yammpay/providers/order_provider.dart';
// import 'package:yammpay/screens/choose_address_screen.dart';
import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/views/card_view.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yammpay/views/widget/button_widget.dart';
import 'package:yammpay/views/widget/page_layout_widget.dart';
import 'package:yammpay/views/widget/page_title_widget.dart';
import 'package:yammpay/views/widget/settings_widget.dart';
import 'package:yammpay/views/widget/snackbar_widget.dart';

class SelectPaymentScreen extends StatefulWidget {
  const SelectPaymentScreen({Key? key}) : super(key: key);
  static const String id = '/ChoosePayementScreen';
  @override
  State<SelectPaymentScreen> createState() => _SelectPaymentScreenState();
}

int selectedValue = 0;
int selectedBank = -1;

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  @override
  void initState() {
    final _bankProvider = Provider.of<BankProvider>(context, listen: false);
    _bankProvider.getBankAccounts();
    // _bankProvider.getBankList();
    super.initState();
  }

  void checkSelectedCard() {
    final _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    if (selectedBank == -1) {
      YammSnackBar.show(body: 'You have to choose a card!');
    } else {
      // Navigator.pushNamed(context, ChooseAdressScreen.id);
      // Get.to(()=>ChooseAdressScreen);
      YammSnackBar.show(header: "Log", body: 'Under Developement');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _bankProvider = Provider.of<BankProvider>(context);

    return PageLayout(
      child: Column(
        children: [
          const PageTitle(title: 'Choose refund method'),
          addVerticalSpace(40.h),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: selectedValue == 1
                          ? Border.all(color: COLOR_PURPLE, width: 3)
                          : Border.all(color: COLOR_BLACK.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Column(
                      children: [
                        RadioListTile<int>(
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: (value) => setState(() {
                            selectedValue = value!;
                          }),
                          title: Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                size: 44.w,
                                color: COLOR_PURPLE,
                              ),
                              addHorizontalSpace(20.w),
                              Text(
                                'Bank Transfer',
                                style: TextStyle(
                                    color: COLOR_BLACK,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        if (selectedValue == 1) BankTransfer(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: selectedValue == 2
                          ? Border.all(color: COLOR_PURPLE, width: 3)
                          : Border.all(color: COLOR_BLACK.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Column(
                      children: [
                        RadioListTile<int>(
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: (value) => setState(() => {
                                selectedValue = value!,
                              }),
                          title: Row(children: [
                            Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Stc_pay.svg/120px-Stc_pay.svg.png'),
                          ]),
                        ),
                        selectedValue == 2
                            ? CustomTextForm(
                                hintText: '9665xxxxxxxx',
                                icon: const Icon(
                                  Icons.phone_rounded,
                                  color: COLOR_PURPLE,
                                ),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(12),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  if (value.length == 12) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              )
                            : const Text(''),
                      ],
                    ),
                  ),
                  Padding(
                    padding: SIDE_PADDING,
                    child: ButtonWidgetPurple(
                        text: 'Continue',
                        onClicked: ()
                            // if (formKey.currentState!.validate())
                            =>
                            checkSelectedCard()),
                  ),
                ],
              ),
            ),
          ),

          // AddNewCard(formKey: formKey),
        ],
      ),
    );
  }
}

class BankTransfer extends StatefulWidget {
  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  @override
  Widget build(BuildContext context) {
    var _bankProvider = Provider.of<BankProvider>(context);
    var _orderProvider = Provider.of<OrderProvider>(context);

    return Column(
      children: [
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          itemCount: _bankProvider.banks.length,
          itemBuilder: ((context, index) {
            return ListTile(
              leading: Radio(
                value: index,
                groupValue: selectedBank,
                onChanged: (value) {
                  setState(() {
                    selectedBank = index;
                    _orderProvider.chosenBank = _bankProvider.banks[index];
                    _orderProvider.bank_id = _orderProvider.chosenBank!.bankId;
                  });
                },
              ),
              title: Text(
                  '${_bankProvider.banks[index].firstName} ${_bankProvider.banks[index].middleName} ${_bankProvider.banks[index].lastName}'),
              subtitle: Text(_bankProvider.banks[index].iban),
              trailing: SizedBox(
                width: 50.w,
                child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Riyad_Bank_logo.svg/1200px-Riyad_Bank_logo.svg.png'),
              ),
            );
          }),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
        const AddNewCardWidget(),
      ],
    );
  }
}
