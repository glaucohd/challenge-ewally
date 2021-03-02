import 'package:ewally_app/components/custom_button.dart';
import 'package:ewally_app/components/custom_text_form_field.dart';
import 'package:ewally_app/constants/constants.dart';
import 'package:ewally_app/ui/home/view/home_view.dart';
import 'package:flutter/material.dart';
import '../../../services/login_service_api.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginServiceApi _loginServiceApi = LoginServiceApi();

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordtController = TextEditingController();

  bool inputTextEnabled = true;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildText("Bem-Vindo!", kHeadline, null),
                buildText("Entre para continuar", kBodyText2, null),
                SizedBox(height: 60),
                CustomTextFormField(
                  labelText: "Login",
                  hintText: "Nome de Usuário",
                  controller: loginController,
                  inputTextEnabled: inputTextEnabled,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: "Senha",
                  hintText: "Senha de acesso",
                  controller: passwordtController,
                  inputTextEnabled: inputTextEnabled,
                  obscure: true,
                ),
                SizedBox(height: 20),
                CustomButton(inputTextEnabled, _authValidade, "Acessar"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String bodyContext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ATENÇÃO'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(bodyContext),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tentar novamente'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _authValidade() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      setState(() {
        inputTextEnabled = false;
      });

      var loginConfirmed = await _loginServiceApi.signIn(
        loginController.text,
        passwordtController.text,
      );

      if (loginConfirmed == true) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeView()),
              (Route route) => false);

          setState(() {
            inputTextEnabled = true;
          });
        });
      } else {
        setState(() {
          inputTextEnabled = true;
        });
        _showMyDialog(_loginServiceApi.errorLoginResult.msg);
      }
    }
  }

  Widget buildText(String textValue, TextStyle textStyle, TextAlign textAlign) {
    return Text(
      textValue,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
