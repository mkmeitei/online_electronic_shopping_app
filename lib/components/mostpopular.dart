import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_electronic_shopping_app/components/product.card.dart';
import 'package:online_electronic_shopping_app/pages/subCategoryPages/single.product.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/get_data.dart';
import 'package:provider/provider.dart';

class MostPopularCategory extends StatelessWidget {
  const MostPopularCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final getdata = Provider.of<GetData>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Most Popular',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward))
            ],
          ),
        ),
        StreamBuilder(
          stream: getdata.getPopularProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: SpinKitCubeGrid(
                color: Colors.black,
              ));
            }

            var data = snapshot.data!.docs;

            if (data.isEmpty) {
              return const Center(
                child: Text('No products available in this category'),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.map((e) {
                  return Container(
                    height: 200,
                    width: 200,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SingleProductPage(
                              documentId: e.id, productName: e["modelName"]),
                        ));
                      },
                      child: ProductCard(
                          img: e["imageUrl"],
                          productModelName: e["modelName"],
                          price: e["price"],
                          productId: e.id),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        )
      ],
    );
  }
}
