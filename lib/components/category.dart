import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/components/category_card.dart';
import 'package:online_electronic_shopping_app/pages/subCategoryPages/category.page.dart';

class CategoryGroup extends StatelessWidget {
  const CategoryGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(category: "laptop"),
                ),
              );
            },
            child: const CategoryCard(
                imagePath: 'assets/images/laptop.png',
                productCategory: "Laptop"),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(category: "tablet"),
                ),
              );
            },
            child: const CategoryCard(
                imagePath: 'assets/images/tablet.png',
                productCategory: 'Tablet'),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(category: "smartphone"),
                ),
              );
            },
            child: const CategoryCard(
                imagePath: 'assets/images/smart phone.png',
                productCategory: 'Smart Phone'),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(category: "telivision"),
                ),
              );
            },
            child: const CategoryCard(
                imagePath: 'assets/images/television.png',
                productCategory: 'Television'),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(category: "smartwatch"),
                ),
              );
            },
            child: const CategoryCard(
                imagePath: 'assets/images/smart watches.png',
                productCategory: 'Smart Watch'),
          )
        ],
      ),
    );
  }
}
