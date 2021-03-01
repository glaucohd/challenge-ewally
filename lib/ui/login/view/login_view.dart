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
                Text(
                  "Bem-Vindo!",
                  style: kHeadline,
                ),
                Text(
                  "Entre para continuar",
                  style: kBodyText2,
                ),
                SizedBox(height: 60),
                buildTextFormField(
                  "Login",
                  "Nome de Usuário",
                  loginController,
                  inputTextEnabled,
                ),
                SizedBox(height: 10),
                buildTextFormField(
                  "Senha",
                  "Senha de acesso",
                  passwordtController,
                  inputTextEnabled,
                  obscure: true,
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xffa71afd),
                            Color(0xff726de1),
                            Color(0xff1afea5),
                          ],
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxWidth: double.infinity, minHeight: 60),
                        child: inputTextEnabled
                            ? Text(
                                'Acessar',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          inputTextEnabled = false;
                        });
                        var usuario = loginController.text;
                        var senha = passwordtController.text;

                        var loginConfirmed =
                            await _loginServiceApi.signIn(usuario, senha);

                        if (loginConfirmed == true) {
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeView()),
                                (Route<dynamic> route) => false);

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
                    },
                  ),
                ),
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

  Widget buildTextFormField(String labelText, String hintText,
      TextEditingController controller, bool inputTextEnabled,
      {bool obscure = false}) {
    return TextFormField(
      enabled: inputTextEnabled,
      obscureText: obscure,
      style: kBodyText.copyWith(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: kBodyText,
        hintText: hintText,
        hintStyle: kBodyText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
      ),
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return "Insira seu $labelText";
        }
        return null;
      },
    );
  }
}
