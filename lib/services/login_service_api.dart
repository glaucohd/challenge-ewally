import 'dart:convert';
import 'package:ewally_app/constants/service_constant.dart';
import 'package:ewally_app/model/error_login_result.dart';
import 'package:ewally_app/model/key_token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginServiceApi {
  ErrorLoginResult errorLoginResult;

  Future<bool> signIn(username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    final response = await http.post(
      ServiceConstant.API_LOGIN,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      Map tokenMap = jsonDecode(response.body);

      //String source = Utf8Decoder().convert(response.bodyBytes);

      Token token = Token.fromJson(tokenMap);

      try {
        if (token.token.isNotEmpty || token.token != null) {
          prefs.setString('token', token.token);

          return true;
        }
      } catch (e) {
        print(e.toString());
      }
    } else if (response.statusCode == 400) {
      Map errorMap = jsonDecode(response.body);

      errorLoginResult = ErrorLoginResult.fromJson(errorMap);

      try {
        return false;
      } catch (e) {
        print(e.toString());
      }
    }

    return false;
  }
}
