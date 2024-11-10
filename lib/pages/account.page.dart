import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/components/icon_text_button.dart';
import 'package:online_electronic_shopping_app/service/auth/auth_service.dart';
import 'package:online_electronic_shopping_app/service/userinfo/user_info.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserInfo>(
                builder: (context, value, child) {
                  return Text("Hi ${value.username}",
                      style: const TextStyle(fontSize: 20));
                },
              ),
              Consumer<UserInfo>(
                builder: (context, value, child) {
                  return Text(value.email,
                      style: const TextStyle(fontSize: 20));
                },
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    IconTextButton(
                        iconData: Icons.shopping_bag_outlined,
                        buttonName: "My purchases",
                        color: Colors.green[200],
                        func: () {}),
                    IconTextButton(
                        iconData: Icons.person_outlined,
                        buttonName: "Personal details and address",
                        color: Colors.green[200],
                        func: () {})
                  ],
                ),
              ),
              IconTextButton(
                  iconData: Icons.inbox_outlined,
                  buttonName: "Inbox",
                  func: () {}),
              IconTextButton(
                  iconData: Icons.settings_outlined,
                  buttonName: "Settings",
                  func: () {}),
              IconTextButton(
                  iconData: Icons.help_outline,
                  buttonName: "Help",
                  func: () {}),
              IconTextButton(
                  iconData: Icons.info_outline,
                  buttonName: "Information",
                  func: () {}),
              IconTextButton(
                iconData: Icons.logout,
                buttonName: "Logout",
                func: authservice.logout,
              )
            ],
          ),
        ),
      ),
    );
  }
}
