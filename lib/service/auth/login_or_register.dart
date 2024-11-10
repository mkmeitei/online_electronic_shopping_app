import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/pages/authenticationPages/login.page.dart';
import 'package:online_electronic_shopping_app/pages/authenticationPages/register.page.dart';

class LoginOrRegsiter extends StatefulWidget {
  const LoginOrRegsiter({super.key});

  @override
  State<LoginOrRegsiter> createState() => _LoginOrRegsiterState();
}

class _LoginOrRegsiterState extends State<LoginOrRegsiter> {
  bool showLoginPage = true; // initially show login page

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
