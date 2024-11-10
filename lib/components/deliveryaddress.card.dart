import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/pages/addaddress.page.dart';
import 'package:online_electronic_shopping_app/service/userActivity/get_data.dart';
import 'package:provider/provider.dart';

class DeliveryAddressCard extends StatefulWidget {
  const DeliveryAddressCard({super.key});

  @override
  State<DeliveryAddressCard> createState() => _DeliveryAddressCardState();
}

class _DeliveryAddressCardState extends State<DeliveryAddressCard> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetData>(context, listen: false).getAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Home Delivery',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Consumer<GetData>(
                    builder: (context, value, child) {
                      return TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddAddressPage(),
                              ));
                        },
                        child: value.name.isEmpty
                            ? const Text('Add address')
                            : const Text('Edit Address'),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 10),
              Consumer<GetData>(
                builder: (context, value, child) {
                  return value.name.isEmpty
                      ? const Text('Add your address')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${value.locality},${value.city},${value.state}-${value.pincode}',
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Phone: ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: value.phone,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
