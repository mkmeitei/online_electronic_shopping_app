import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {super.key, required this.text, required this.icon, this.onTap});

  final String text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey,
        ),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
