// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yamm_refund/models/bank.dart';
// import 'package:yamm_refund/models/banks.dart';
// import 'package:yamm_refund/models/reaosn.dart';

// class BankServices {
//   static final baseURL = 'https://api.yammpay.com/customer';
//   static final bankAccounts = '/bankAccounts';

//   Future<http.Response?> addBankAccount(String first_name, String middle_name,
//       String last_name, String iban, String bank_id) async {
//     http.Response? response;
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     ;
//     try {
//       response = await http.post(
//         Uri.parse(baseURL + bankAccounts),
//         body: {
//           "first_name": first_name,
//           "middle_name": middle_name,
//           "last_name": last_name,
//           "iban": iban,
//           "bank_id": bank_id,
//         },
//         headers: {"Authorization": "Bearer $token"},
//       );
//     } catch (e) {
//       log(e.toString());
//     }
//     return response;
//   }

//   Future<List<Bank>> fetchBankAccounts() async {
//     List<Bank> banks = [];
//     http.Response? response;
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     ;
//     try {
//       response = await http.get(
//         Uri.parse(baseURL + bankAccounts),
//         headers: {
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         var rest = (jsonResponse['data']) as List;
//         banks = rest.map<Bank>((json) => Bank.fromJson(json)).toList();
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     return banks;
//   }

//   Future deleteBankAccount(String id) async {
//     http.Response? response;
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     ;
//     try {
//       response = await http.delete(
//         Uri.parse(baseURL + bankAccounts + '/$id'),
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         print('Note $id is deleted!');
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   Future<List<BankList>> returnBanks() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');
//     List<BankList> banks = [];
//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse('https://api.yammpay.com/banks'),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         var rest = (jsonResponse['data']) as List;
//         banks = rest.map<BankList>((bank) => BankList.fromMap(bank)).toList();
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }

//     return banks;
//   }
// }
