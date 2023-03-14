import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yammpay/config/themes/constants.dart';
import 'package:yammpay/models/bank_list.dart';
import 'package:yammpay/providers/bank_provider.dart';
import 'package:yammpay/views/widget/addspace_widget.dart';
import 'package:yammpay/views/widget/button_widget.dart';
import 'package:yammpay/views/widget/loading_widget.dart';
import 'package:yammpay/views/widget/settings_widget.dart';
import 'package:yammpay/views/widget/snackbar_widget.dart';



Future<dynamic> addNewCardDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Center(
            child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: addCartLayout(),
          ),
        ));
      });
}

class addCartLayout extends StatefulWidget {
  const addCartLayout({Key? key}) : super(key: key);

  @override
  State<addCartLayout> createState() => _addCartLayoutState();
}

class _addCartLayoutState extends State<addCartLayout> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  String selectedReason = '';
  BankList? selectedBank;
  void initState() {
    final _bankProvider = Provider.of<BankProvider>(context, listen: false);
    // _bankProvider.getBankList();
    super.initState();
  }

  Future<void> _addBankAcount() async {
    var _bankProvider = Provider.of<BankProvider>(context, listen: false);

    //* Call the method
    await _bankProvider.postBankAccounts(
        firstNameController.text,
        middleNameController.text,
        lastNameController.text,
        ibanController.text,
        selectedBank!.id.toString());
    if (_bankProvider.hasError) {
      YammSnackBar.show(body: _bankProvider.errorMessage);
    } else if (_bankProvider.isSaved) {
      YammSnackBar.show(
          body: "Account added successfully!", type: MessageType.succses);
      Navigator.pop(context);
      _bankProvider.getBankAccounts();
    } else {
      YammSnackBar.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final _bankProvider = Provider.of<BankProvider>(context);
    // selectedBank = _bankProvider.bankList[0];
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.all(PADDING),
        child: Form(
          key: formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            // _bankProvider.isLoading
            //     ? Center(child: LoadingSpinner(size: 40.w))
            //     : SizedBox(
            //         width: double.infinity,
            //         child: DropdownButton2(
            //           isDense: true,
            //           isExpanded: true,
            //           offset: const Offset(0, -6),
            //           dropdownMaxHeight: 350.h,
            //           buttonPadding: EdgeInsets.symmetric(horizontal: 12.w),
            //           buttonHeight: 60.h,
            //           buttonDecoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15.r),
            //             border: Border.all(
            //                 color: COLOR_BLACK.withOpacity(0.4), width: 2),
            //           ),
            //           dropdownDecoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15.r),
            //           ),
            //           value: selectedReason == ''
            //               ? _bankProvider.bankList[0].name
            //               : selectedReason,
            //           items: _bankProvider.bankList
            //               .map((bank) => bank.name)
            //               .toList()
            //               .map((item) => DropdownMenuItem(
            //                     value: item,
            //                     child: Text(
            //                       item,
            //                       style: TextStyle(
            //                           fontSize: 18.sp,
            //                           fontWeight: FontWeight.w600),
            //                     ),
            //                   ))
            //               .toList(),
            //           onChanged: (item) => setState(
            //             () {
            //               selectedReason = item as String;
            //               for (int i = 0;
            //                   i < _bankProvider.bankList.length;
            //                   i++) {
            //                 if (_bankProvider.bankList[i].name ==
            //                     selectedReason) {
            //                   selectedBank = _bankProvider.bankList[i];
            //                 }
            //               }
            //             },
            //           ),
            //         )),
            // addVerticalSpace(15.h),
            CustomTextForm(
              // hintText: translation(context).credit_number,
              hintText: "IBAN Number",
              onChanged: (iban) => {
                if (iban.length == 4){
                  _bankProvider.validIBAN =true
                }
              },
              onEditingComplete: ()=>{
                _bankProvider.checkIBAN()
              },
              icon: const Icon(
                Icons.credit_card,
                color: COLOR_PURPLE,
              ),
              controller: ibanController,
            ),
            addVerticalSpace(15.h),
            // if(_bankProvider.validIBAN)...[
            //   Expanded(child: Container(child: Text("f"),
            //   color: COLOR_GREY,)),
            //   addVerticalSpace(15.h),
            // ],
            CustomTextForm(
                // hintText: translation(context).firstname,
                hintText: "First Name",
                controller: firstNameController,
                icon: const Icon(
                  Icons.person,
                  color: COLOR_PURPLE,
                )),
            addVerticalSpace(15.h),
            CustomTextForm(
              hintText: 'Middle Name (Optional)',
              controller: middleNameController,
              icon: const Icon(
                Icons.person,
                color: COLOR_PURPLE,
              ),
              validate: false,
            ),
            addVerticalSpace(15.h),
            CustomTextForm(
                // hintText: translation(context).lastname,
                hintText: "Last Name",
                controller: lastNameController,
                icon: const Icon(
                  Icons.person,
                  color: COLOR_PURPLE,
                )),
            addVerticalSpace(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                
                ButtonWidget(
                  
                  text: "Add Card",
                  onClicked: () {
                    if (formKey.currentState!.validate()) {
                      _bankProvider.iban = ibanController.text;
                      if(_bankProvider.validIBAN){
                        _addBankAcount();
                      }
                      else{
                        YammSnackBar.show(type: MessageType.error, body: "Sorry, Your IBAN is not vaild");
                      }
                      }
                  },
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
