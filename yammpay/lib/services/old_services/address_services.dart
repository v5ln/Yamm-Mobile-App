// import 'dart:convert';
// import 'dart:developer';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:yamm_refund/models/address.dart';

// class AddressService {
//   static final baseURL = 'https://api.yammpay.com';
//   static final customerEndPoint = '/customer';
//   static final statesByCountryIdEndPoint =
//       'https://api.yammpay.com/states?country=';
//   static final citiesByStateIdEndPoint =
//       'https://api.yammpay.com/cities?state=';
//   static final countriesEndPoint = '/countries';
//   static final statesEndPoint = '/states';
//   static final citiesEndPoint = '/cities';
//   static final addressEndPoint = '/addresses';

//   Future returnAllCountries() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');

//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse(baseURL + countriesEndPoint),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         return (jsonResponse['data']) as List;
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     throw Exception();
//   }

//   Future returnAllStates() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');

//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse(baseURL + statesEndPoint),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         return (jsonResponse['data']) as List;
//       } else {
//         print('error in returnAllStates');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     throw Exception();
//   }

//   Future returnStatesByCountryId(String id) async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');

//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse(statesByCountryIdEndPoint + id),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         var rest = (jsonResponse['data']) as List;
//         return rest;
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     throw Exception();
//   }

//   Future returnAllCities() async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');

//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse(baseURL + citiesEndPoint),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         return (jsonResponse['data']) as List;
//       } else {
//         print('error in returnAllCities');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     throw Exception();
//   }

//   Future returnCitiesByStateId(String id) async {
//     var prefs = await SharedPreferences.getInstance();
//     String? lang = prefs.getString('LanguageCode');
//     lang == 'ar' ? lang = 'en' : lang = 'ar';
//     String? token = prefs.getString('token');

//     http.Response? response;
//     try {
//       response = await http.get(
//         Uri.parse(citiesByStateIdEndPoint + id),
//         headers: {
//           "Accept-Language": lang,
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         var rest = (jsonResponse['data']) as List;
//         return rest;
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     throw Exception();
//   }

//   Future<http.Response?> addAddress(
//     String country_id,
//     String state_id,
//     String city_id,
//   ) async {
//     http.Response? response;
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     ;
//     try {
//       response = await http.post(
//         Uri.parse(baseURL + customerEndPoint + addressEndPoint),
//         body: {
//           "country_id": country_id,
//           "state_id": state_id,
//           "city_id": city_id
//         },
//         headers: {"Authorization": "Bearer $token"},
//       );
//     } catch (e) {
//       log(e.toString());
//     }
//     return response;
//   }

//   Future<List<Address>> fetchAddresses() async {
//     List<Address> addresses = [];
//     http.Response? response;
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     ;
//     try {
//       response = await http.get(
//         Uri.parse(baseURL + customerEndPoint + addressEndPoint),
//         headers: {
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         var rest = (jsonResponse['data']) as List;
//         addresses = rest.map<Address>((json) => Address.fromMap(json)).toList();
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     return addresses;
//   }

//   Future deleteAddress(String id) async {
//     http.Response? response;
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     ;
//     try {
//       response = await http.delete(
//         Uri.parse(baseURL + customerEndPoint + addressEndPoint + '/$id'),
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );
//       if (response.statusCode == 200) {
//         print('Address $id is deleted!');
//       } else {
//         print('error');
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
