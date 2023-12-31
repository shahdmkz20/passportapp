import 'package:ayat_project/componants/form_validator.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';

class InputTextForm extends StatelessWidget {
  final FormValidator formValidator;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool showText;
  final VoidCallback? suffixPressed;
  final TextInputType textInputType;
  final TextEditingController controller;

  const InputTextForm({
    Key? key,
    required this.formValidator,
    this.suffixIcon,
      this.prefixIcon,
    this.suffixPressed,
    this.showText = true,
    required this.textInputType,
    required this.controller,
  }) : super(key: key);

  Widget? _getSuffixIcon() {
    if (suffixIcon == null) return null;
    return IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffixIcon,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
        ),
        validator: formValidator.validator,
        keyboardType: textInputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.defaultWhite,
          labelText: formValidator.hint,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          suffixIcon: _getSuffixIcon(),
        ),
        obscureText: !showText,
      ),
    );
  }
}
