// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_electronic_shopping_app/components/cart.card.dart';
import 'package:online_electronic_shopping_app/pages/checkout.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    final cartlogic = Provider.of<CartLogic>(context, listen: false);
    cartlogic.loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    final cartlogic = Provider.of<CartLogic>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'SHOPPING CART',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Consumer<CartLogic>(
                  builder: (context, value, child) {
                    return Text(
                      'Product in Cart: ${value.cartItems.length}',
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Fee',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Free',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Divider(color: Colors.green[900]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SubTotal',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Consumer<CartLogic>(
                              builder: (context, value, child) {
                                return Text(
                                  NumberFormat.simpleCurrency(locale: 'hi-IN')
                                      .format(double.parse(value
                                          .calculateTotalPrice()
                                          .toString())),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (cartlogic.cartItems.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Empty Cart'),
                        content: const Text(
                            'Your cart is empty. Add items before checking out.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CheckoutPage(),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 50),
                    backgroundColor: Colors.green[900]),
                child: const Text('Place Order'),
              ),
            ],
          ),
          Expanded(
            child: Consumer<CartLogic>(
              builder: (context, value, child) {
                if (value.cartItems.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your cart is empty.'),
                        Icon(Icons.shopping_cart, size: 150)
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: value.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartCard(
                      docuId: index,
                      imgUrl: value.cartItems[index]["imageUrl"],
                      modelName: value.cartItems[index]["modelName"],
                      price: value.cartItems[index]["price"],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
