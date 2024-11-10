import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_electronic_shopping_app/components/login_text_field.dart';
import 'package:online_electronic_shopping_app/pages/home.page.dart';
import 'package:online_electronic_shopping_app/service/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final checkPasswordController = TextEditingController();

  bool isLoading = false;

  void signUp() async {
    setState(() {
      isLoading = true;
    });

    if (passwordController.text != checkPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassowrd(
          emailController.text, passwordController.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'assets/images/e-store-high-resolution-logo-transparent.png',
                  width: 250),
              const SizedBox(height: 30),
              LoginTextField(
                  hintText: "Email Address",
                  inputIcon: Icons.email,
                  isPassword: false,
                  textController: emailController),
              const SizedBox(height: 20),
              LoginTextField(
                  hintText: "Password",
                  inputIcon: Icons.lock,
                  isPassword: true,
                  textController: passwordController),
              const SizedBox(height: 20),
              LoginTextField(
                  hintText: "Re-enter Password",
                  inputIcon: Icons.lock,
                  isPassword: true,
                  textController: checkPasswordController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50)),
                child: isLoading
                    ? const SpinKitCircle(
                        color: Colors.white,
                        size: 25,
                      )
                    : const Text(
                        'REGISTER',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a user?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
