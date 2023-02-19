import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yammpay/models/app_sharedprefrences.dart';
import 'package:yammpay/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  bool customerExists = false;
  bool hasError = false;
  bool otpVerified = false;
  bool status = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String phone_number = '';
  String national_id = '123456789';
  String date_of_birth = '1999/5/5';
  String otp = '';
  String token = '';
  String appLang = 'en';
  String digitalAgreementText = '';
  List<dynamic> faqs = [];


  Future<void> postLogin(String phone_number, String otp) async {

    // * Show loading screen when the method is being called
    isLoading = true;
    hasError = false;
    notifyListeners();
    // * Take the response to habdle errors or the OK states
    http.Response response = (await AuthServices().login(phone_number, otp))!;
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 400) {
      hasError = true;
      errorMessage = jsonResponse["errors"][0]["message"];
    } else if (response.statusCode == 200) {
      hasError = false;
      isLoggedIn = true;
      status = jsonResponse["records"]["status"];

      // * Save the token in a local storage when the user logs in.
      token = jsonResponse["records"]["accessToken"]['token'];
      AppSharedPreference.saveToken('token', token);
      // print(token);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> postRegister(String phone_number, String national_id,
      String date_of_birth, String otp) async {
    isLoading = true;
    hasError = false;
    notifyListeners();
    http.Response response = (await AuthServices()
        .register(phone_number, national_id, date_of_birth, otp))!;
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 400) {
      hasError = true;
      errorMessage = jsonResponse["errors"][0]["message"];
    } else if (response.statusCode == 200) {
      hasError = false;

      token = jsonResponse["records"]["accessToken"]['token'];
      AppSharedPreference.saveToken('token', token);
      status = jsonResponse["records"]["status"];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> postSendOTP(String phone_number) async {
    // * Show loading screen when the method is being called
    isLoading = true;
    notifyListeners();
    // * Take the response to habdle errors
    http.Response response = (await AuthServices().sendOTP(phone_number))!;
    final jsonResponse = jsonDecode(response.body);
    // * If there is an error
    if (response.statusCode == 400) {
      hasError = true;
      errorMessage = jsonResponse["errors"][0]["message"];
      // * If the number is valid
    } else if (response.statusCode == 200) {
      // * To stop showing the snack bar if the first try had an error
      hasError = false;
      this.phone_number = phone_number;

      // * Save the OTP and check if the user exists
      final otp = jsonResponse["records"]["otp"];
      customerExists = jsonResponse["records"]["customerExists"];
      this.otp = otp;
      print('Your OTP number is: ' + otp);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> postVerifyOTP(String phone_number, String otp) async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    http.Response response =
        (await AuthServices().verifyOTP(phone_number, otp))!;
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 400) {
      hasError = true;
      errorMessage = jsonResponse["errors"][0]["message"];
    } else if (response.statusCode == 200) {
      hasError = false;
      otpVerified = jsonResponse["records"]["verify"];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getDegitalAgreement() async {
    isLoading = true;
    notifyListeners();
    digitalAgreementText = (await AuthServices().returnDigitalAgreement());
    isLoading = false;
    notifyListeners();
  }

  Future<void> getFaqs() async {
    isLoading = true;
    notifyListeners();
    faqs = (await AuthServices().returnFaqs());
    isLoading = false;
    notifyListeners();
  }

  void checkLogin() async {
    String prefs = await AppSharedPreference.readToken('token');
    isLoggedIn = prefs == null ? false : true;
    notifyListeners();
  }

  Future<void> LogOff() async {
    await AppSharedPreference.removeToken('token');
    isLoggedIn = false;
    notifyListeners();
  }
}
