import 'package:flutter/cupertino.dart';

class FormValidator {
  String hint;
  RegExp regExp;
  String errorMessage;
  final TextEditingController controller = TextEditingController();

  FormValidator(
      {required this.hint, required this.regExp, required this.errorMessage});

  String? validator(String? inputText) {
    return regExp.hasMatch(inputText!) ? null : errorMessage;
  }
}
