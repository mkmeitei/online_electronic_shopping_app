import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.imagePath, required this.productCategory});

  final String imagePath;
  final String productCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.grey[200],
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 130,
                width: 130,
              ),
            ],
          ),
        ),
        Text(productCategory)
      ],
    );
  }
}
