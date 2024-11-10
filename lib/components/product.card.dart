import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_electronic_shopping_app/service/userActivity/favourite.activity.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.img,
      required this.productModelName,
      required this.price,
      required this.productId});

  final String img;
  final String productModelName;
  final String price;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 120,
                color: Colors.grey,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ),
              );
            },
            img,
            fit: BoxFit.cover,
            height: 120,
            width: 200,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else if (loadingProgress.cumulativeBytesLoaded ==
                  loadingProgress.expectedTotalBytes) {
                return child;
              } else {
                return Container(
                  height: 120,
                  width: 200,
                  color: Colors.grey,
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModelName,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                      Text(
                        NumberFormat.simpleCurrency(locale: 'hi-IN')
                            .format(double.parse(price)),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Consumer<FavouriteLogic>(
                  builder: (context, value, child) {
                    bool isFavourite = value.favouriteItem
                        .any((element) => element == productId);
                    return IconButton(
                        onPressed: () {
                          value.onTapped(productId);
                        },
                        icon: Icon(Icons.favorite,
                            color: isFavourite ? Colors.red : Colors.grey));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
