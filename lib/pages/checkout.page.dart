import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_electronic_shopping_app/components/deliveryaddress.card.dart';
import 'package:online_electronic_shopping_app/components/payment.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'ORDER CONFIRMATION',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Consumer<CartLogic>(
                builder: (context, value, child) {
                  return Text(
                    'Product in Cart: ${value.cartItems.length}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  );
                },
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
                                  NumberFormat.simpleCurrency(locale: 'hi-IN').format(double.parse(value.calculateTotalPrice().toString())),
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
              const DeliveryAddressCard(),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: const ExpansionTile(
                  title: Text('Expected Delivery'),
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: const Text('Amount Payable'),
                  backgroundColor: Colors.white,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Delivery Free'),
                                SizedBox(height: 5),
                                Text('Platform Fee'),
                                SizedBox(height: 5),
                                Text('Order Total')
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Free'),
                                const SizedBox(height: 5),
                                const Text('25'),
                                Consumer<CartLogic>(
                                  builder: (context, value, child) {
                                    return Text(
                                      NumberFormat.simpleCurrency(
                                              locale: 'hi-IN')
                                          .format(double.parse(value
                                              .calculateOrderTotal()
                                              .toString())),
                                    );
                                  },
                                )
                              ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(color: Colors.white, child: const PaymentExpansionTile())
            ],
          ),
        ],
      ),
    );
  }
}
