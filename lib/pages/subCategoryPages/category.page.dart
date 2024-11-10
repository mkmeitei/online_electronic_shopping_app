import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_electronic_shopping_app/components/product.card.dart';
import 'package:online_electronic_shopping_app/pages/subCategoryPages/single.product.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/get_data.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category});

  final String category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: GetData().getProducts(widget.category),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SpinKitCircle(
              color: Colors.black,
            ));
          }

          var data = snapshot.data!.docs;

          if (data.isEmpty) {
            return const Center(
              child: Text('No products available in this category'),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SingleProductPage(
                            documentId: data[index].id,
                            productName: data[index]["modelName"]),
                      ),
                    );
                  },
                  child: ProductCard(
                    img: data[index]["imageUrl"],
                    productModelName: data[index]["modelName"],
                    price: data[index]["price"],
                    productId: data[index].id,
                  ));
            },
          );
        },
      ),
    );
  }
}
