import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:online_electronic_shopping_app/pages/home.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:provider/provider.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<CartLogic>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ordered Successfully"),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
          future: order.orderId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the result, you can show a loading indicator
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle errors if any
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // If data is available, you can access it through snapshot.data
              Map<String, dynamic>? orderData = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LottieBuilder.asset(
                    'assets/animation/lottie.success.json',
                    width: MediaQuery.of(context).size.width,
                    // height: ,
                    fit: BoxFit.fill,
                    repeat: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ${orderData?['orderId']}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Name: ${orderData?['name']}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Phone: ${orderData?['phoneNumber']}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Address: ${orderData?['locality']}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Total: ${NumberFormat.simpleCurrency(locale: 'hi-IN').format(orderData?["totalAmount"])}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ));
                            },
                            icon: const Icon(
                              Icons.home,
                              size: 50,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  // Add other UI elements based on orderData
                ],
              );
            } else {
              // Handle the case where data is null
              return const Text('No order data available');
            }
          },
        ),
      ),
    );
  }
}
