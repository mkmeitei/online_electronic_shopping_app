import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_electronic_shopping_app/service/userActivity/cart.activity.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.docuId,
    required this.imgUrl,
    required this.price,
    required this.modelName,
  });

  final int docuId;
  final String imgUrl;
  final String price;
  final String modelName;

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<CartLogic>(context, listen: false);
    return Card(
      child: Row(
        children: [
          Row(
            children: [
              Image.network(
                imgUrl,
                height: 130,
                width: 130,
                
              )
            ],
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modelName,
                  overflow: TextOverflow.clip,
                ),
                const SizedBox(height: 5),
                Text(
                  NumberFormat.simpleCurrency(locale: 'hi-IN')
                      .format(double.parse(price)),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              value.removeItemFromCart(docuId);
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
