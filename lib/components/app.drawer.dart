import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_electronic_shopping_app/components/drawer.list_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.shopping_bag,
                size: 72,
              ),
            ),
            DrawerListTile(
              text: "Shop",
              icon: Icons.home,
              onTap: () {},
            ),
            DrawerListTile(
              text: "Cart",
              icon: Icons.shopping_cart,
              onTap: () {},
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: DrawerListTile(
            text: "Exit",
            icon: Icons.exit_to_app,
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        )
      ],
    ));
  }
}
