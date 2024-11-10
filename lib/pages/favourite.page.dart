import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/components/product.card.dart';
import 'package:online_electronic_shopping_app/pages/subCategoryPages/single.product.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/favourite.activity.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavouriteLogic>(context, listen: false).loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteLogic = Provider.of<FavouriteLogic>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAVOURITE',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: favouriteLogic.favouriteItem.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_sharp, color: Colors.red, size: 200),
                  Text(
                    'Your Favourite is empty',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            )
          : StreamBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
              stream: favouriteLogic
                  .getFavouriteItems(favouriteLogic.favouriteItem),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error ${snapshot.error}'),
                  );
                } else {
                  List<DocumentSnapshot<Map<String, dynamic>>> data =
                      snapshot.data ?? [];

                  return GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SingleProductPage(
                                  documentId: data[index].id,
                                  productName: data[index]['modelName']),
                            ),
                          );
                        },
                        child: ProductCard(
                            img: data[index]["imageUrl"],
                            productModelName: data[index]["modelName"],
                            price: data[index]["price"],
                            productId: data[index].id),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
