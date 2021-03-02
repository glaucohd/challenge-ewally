import 'package:flutter/material.dart';

import 'package:ewally_app/constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool inputTextEnabled;
  final bool obscure;

  const CustomTextFormField({
    Key key,
    this.labelText,
    this.hintText,
    this.controller,
    this.inputTextEnabled,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
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
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
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
