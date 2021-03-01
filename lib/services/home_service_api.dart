import 'dart:convert';
import 'package:ewally_app/constants/service_constant.dart';
import 'package:ewally_app/model/balance.dart';
import 'package:ewally_app/model/key_token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeServiceApi {
  Token token = Token();
  Balance balance = Balance();

  Future<bool> getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token');

    final response = await http.get(ServiceConstant.API_GET_BALANCE, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    Map tokenMap = jsonDecode(response.body);

    String responseBody = response.body;

    if (responseBody != null) {
      balance = Balance.fromJson(tokenMap);

      prefs.setInt('balance', balance.balance);
    }

    return true;
  }
}
