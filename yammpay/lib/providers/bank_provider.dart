import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yammpay/models/bank_list.dart';
import 'package:yammpay/services/bank_services.dart';

import '../models/bank.dart';

class BankProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  bool isSaved = false;
  String errorMessage = '';
  List<Bank> banks = [];
  String iban ='';
  late BankList selectedBank;
  
  bool validIBAN = false;
  // List<BankList> bankList = [];

  Future<void> postBankAccounts(String first_name, String middle_name,
      String last_name, String iban, String bank_id) async {
    // * Show loading screen when the method is being called
    isLoading = true;
    notifyListeners();
    // * Take the response to habdle errors
    http.Response response = (await BankServices()
        .addBankAccount(first_name, middle_name, last_name, iban, bank_id))!;
    final jsonResponse = jsonDecode(response.body);
    // * If there is an error
    if (response.statusCode == 400) {
      hasError = true;
      errorMessage = jsonResponse["errors"][0]["message"];
      // * If the number is valid
    } else if (response.statusCode == 200) {
      // * To stop showing the snack bar if the first try had an error
      hasError = false;
      isSaved = true;
    }
    isLoading = false;
    notifyListeners();
  }

  getBankAccounts() async {
    isLoading = true;
    banks = (await BankServices().fetchBankAccounts());
    isLoading = false;
    notifyListeners();
  }

  checkIBAN(){
    validIBAN = true;
    notifyListeners();
    // isLoading = true; 
    // notifyListeners();
    // validIBAN = (await BankServices().checkIBAN(iban));
    // if (validIBAN){
    //   selectedBank = (await BankServices().getDetail(iban));
    // }
    // isLoading = false;
    // notifyListeners();
  }

  deleteBankAccount(String id) async {
    isLoading = true;
    notifyListeners();
    await BankServices().deleteBankAccount(id);
    await getBankAccounts();
    isLoading = false;
    notifyListeners();
  }


  

  // getBankList() async {
  //   isLoading = true;
  //   bankList = (await BankServices().returnBanks());
  //   isLoading = false;
  //   notifyListeners();
  // }
}
