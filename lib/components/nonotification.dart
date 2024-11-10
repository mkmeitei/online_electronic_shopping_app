import 'package:flutter/material.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('NO NOTIFICATION',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text('We will notify you once we have something for you'),
          const SizedBox(height: 5),
          Image.asset("assets/images/nonoti.png")
        ],
      ),
    );
  }
}


