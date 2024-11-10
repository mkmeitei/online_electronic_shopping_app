import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/components/nonotification.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final id = TextEditingController();

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('NOTIFICATIONS',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black87)),
          backgroundColor: Colors.white,
          // shadowColor: Colors.transparent,
          elevation: 5,
        ),
        body: isEmpty
            ? const Column(
                children: [],
              )
            : const Center(child: NoNotification()));
  }
}
