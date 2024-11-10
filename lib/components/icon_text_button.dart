import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.iconData,
    required this.buttonName,
    required this.func,
    this.color,
  });

  final IconData iconData;
  final String buttonName;
  final Function func;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => func(),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 40,
                color: color,
              ),
              const SizedBox(width: 5),
              Text(buttonName, style: const TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
