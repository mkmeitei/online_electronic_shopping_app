import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/pages/order.confirmation.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentExpansionTile extends StatefulWidget {
  const PaymentExpansionTile({super.key});

  @override
  State<PaymentExpansionTile> createState() => _PaymentExpansionTileState();
}

class _PaymentExpansionTileState extends State<PaymentExpansionTile> {
  bool showCOD = false;
  @override
  Widget build(BuildContext context) {
    final cartLogic = Provider.of<CartLogic>(context, listen: false);
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text('Payment'),
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Offers & Promotions'),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'All Offers',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                    'Get 10% Instant Discount of up to Rs. 1000 on a minimum transaction value of Rs 3500 using AU Credit & Debit Cards')
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('+ 7 more offers'),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Cash on Delivery'),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showCOD = !showCOD;
                          });
                        },
                        icon: showCOD
                            ? const Icon(Icons.minimize)
                            : const Icon(Icons.add),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: showCOD,
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      children: [
                        const Text(
                            '₹29.00 will be charged extra for Cash on Delivery'),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (prefs.getString('name') == null) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content:
                                        Text('Address details cannot be empty'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Ok'))
                                    ],
                                  );
                                },
                              );
                            } else {
                              cartLogic.addOrder();

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrderConfirmationPage(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Colors.black),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
