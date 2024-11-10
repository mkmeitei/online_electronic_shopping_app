import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/pages/account.page.dart';
import 'package:online_electronic_shopping_app/pages/cart.page.dart';
import 'package:online_electronic_shopping_app/pages/favourite.page.dart';
import 'package:online_electronic_shopping_app/pages/main.page.dart';
import 'package:online_electronic_shopping_app/pages/notification.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Pages
  final List<Widget> _pages = [
    const MainPage(),
    const CartPage(),
    const FavouritePage(),
    NotificationPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Consumer<CartLogic>(
                builder: (context, value, child) {
                  return Badge(
                    isLabelVisible: value.cartItems.isNotEmpty,
                    label: Text(value.cartItems.length.toString()),
                    child: const Icon(Icons.shopping_cart),
                  );
                },
              ),
              label: 'Cart'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Account'),
        ],
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black45,
      ),
    );
  }
}
