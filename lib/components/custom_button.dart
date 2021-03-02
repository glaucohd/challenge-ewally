import 'package:ewally_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool inputTextEnabled;
  final Function function;
  final String textValue;

  CustomButton(
    this.inputTextEnabled,
    this.function,
    this.textValue,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: kLinearGradientCustom,
          ),
          child: Container(
            alignment: Alignment.center,
            constraints:
                BoxConstraints(maxWidth: double.infinity, minHeight: 60),
            child: inputTextEnabled
                ? Text(
                    textValue,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: function,
      ),
    );
  }
}
