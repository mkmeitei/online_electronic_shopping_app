import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/components/app.drawer.dart';
import 'package:online_electronic_shopping_app/components/carousel.category.dart';
import 'package:online_electronic_shopping_app/components/category.dart';
import 'package:online_electronic_shopping_app/components/mostpopular.dart';
import 'package:online_electronic_shopping_app/pages/cart.page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: Colors.black),
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.black))
        ],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CarouselCategory(),
              const CategoryGroup(),
              const MostPopularCategory()
            ],
          ),
        ),
      ),
    );
  }
}
