import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_electronic_shopping_app/pages/cart.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:online_electronic_shopping_app/service/userActivity/favourite.activity.dart';
import 'package:online_electronic_shopping_app/service/userActivity/get_data.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({
    Key? key,
    required this.documentId,
    required this.productName,
  }) : super(key: key);

  final String documentId;
  final String productName;

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    final cartlogic = Provider.of<CartLogic>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.productName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: GetData().getSingleProduct(widget.documentId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitCircle(
                color: Colors.black,
              ),
            );
          }
          var data = snapshot.data!.data();

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  data?["imageUrl"],
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data?["modelName"],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<FavouriteLogic>(
                        builder: (context, value, child) {
                          bool isFavourite = value.favouriteItem
                              .any((element) => element == widget.documentId);
                          return IconButton(
                            onPressed: () {
                              value.onTapped(widget.documentId);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: isFavourite ? Colors.red : Colors.grey,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  'MRP ${NumberFormat.simpleCurrency(locale: 'hi-IN').format(double.parse(data?["price"]))}',
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const SizedBox(height: 10),
                _buildProductDetailsTable(data),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(170, 50),
                        elevation: 1,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.green[900]!),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Place Order',
                        style: TextStyle(color: Colors.green[900]),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Consumer<CartLogic>(
                      builder: (context, value, child) {
                        return value.cartItems.any(
                          (element) => element["itemid"] == widget.documentId,
                        )
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(170, 50),
                                  elevation: 1,
                                  backgroundColor: Colors.red[900],
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const CartPage(),
                                  ));
                                },
                                child: const Text('Go to Cart'),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(170, 50),
                                  elevation: 1,
                                  backgroundColor: Colors.green[900],
                                ),
                                onPressed: () {
                                  cartlogic.addToCart(
                                    itemId: widget.documentId,
                                    modelname: data!["modelName"],
                                    imageUrl: data["imageUrl"],
                                    price: data["price"],
                                  );
                                },
                                child: const Text('Add to Cart'),
                              );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetailsTable(Map<String, dynamic>? data) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FixedColumnWidth(120),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _buildTableRow("Company", data?["company"] ?? "No Data"),
        _buildTableRow(
            "Processor Model", data?["processorModel"].toString() ?? "No Data"),
        _buildTableRow("Display", data?["display"].toString() ?? "No Data"),
        _buildTableRow(
            "Graphics Card", data?["graphicsCard"].toString() ?? "No Data"),
        _buildTableRow("Memory", data?["memory"] ?? "No Data"),
        _buildTableRow(
            "Operating System", data?["operatingSystem"] ?? "No Data"),
        _buildTableRow(
            "Processor Company", data?["processorCompany"] ?? "No Data"),
        _buildTableRow("Storage", data?["storage"] ?? "No Data"),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
