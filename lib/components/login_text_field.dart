import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {super.key,
      required this.hintText,
      required this.inputIcon,
      required this.isPassword,
      required this.textController});

  final String hintText;

  final IconData inputIcon;

  final bool isPassword;

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: Icon(inputIcon),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
