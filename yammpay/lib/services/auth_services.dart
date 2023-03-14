import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static const baseURL = 'https://api.yammrefund.com/customer';
  static const baseUrlNoCustomer = 'https://api.yammrefund.com';
  static const registerEndPoint = '/register';
  static const loginEndPoint = '/login';
  static const sendOtpEndPoint = '/sendOTP';
  static const verifyOtpEndPoint = '/verifyOTP';
  static const absherOtpEndpoint = '/verifyAbsher';
  static const agreementEndPoint = '/agreement';

  Future<http.Response?> register(String phone_number, String national_id,
      String date_of_birth, String otp) async {
    http.Response? response;
    try {
      response = await http.post(Uri.parse(baseURL + registerEndPoint), body: {
        "phone_number": phone_number,
        "national_id": national_id,
        'date_of_birth': date_of_birth,
        "otp": otp
      });
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<http.Response?> login(String phone_number, String otp) async {
    http.Response? response;

    try {
      response = await http.post(Uri.parse(baseURL + loginEndPoint),
          body: {"phone_number": phone_number, "otp": otp});
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<http.Response?> sendOTP(String phone_number) async {
    http.Response? response;
    try {
      response = await http.post(Uri.parse(baseURL + sendOtpEndPoint),
          body: {"phone_number": phone_number});
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<http.Response?> verifyOTP(String phone_number, String otp) async {
    http.Response? response;
    try {
      response = await http.post(Uri.parse(baseURL + verifyOtpEndPoint),
          body: {"phone_number": phone_number, "otp": otp});
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<String> returnDigitalAgreement() async {
    String agreement = '';
    http.Response? response;
    try {
      response =
          await http.get(Uri.parse(baseUrlNoCustomer + agreementEndPoint));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        agreement = jsonResponse['data'][0]['agreement'];
      }
    } catch (e) {
      log(e.toString());
    }
    return agreement;
  }

  Future<List<dynamic>> returnFaqs() async {
    List<dynamic> faqs = [];
    http.Response? response;
    try {
      response = await http.get(Uri.parse(baseUrlNoCustomer + '/FAQ'));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        faqs = jsonResponse['data'];
      }
    } catch (e) {
      log(e.toString());
    }
    return faqs;
  }
}
