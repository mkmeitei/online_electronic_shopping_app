import 'package:flutter/material.dart';

class CardCarousel extends StatelessWidget {
  const CardCarousel({super.key, required this.discountImagePath});

  final String discountImagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      discountImagePath,
      fit: BoxFit.cover,
    ));
  }
}
