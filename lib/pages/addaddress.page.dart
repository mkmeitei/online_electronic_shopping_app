import 'package:flutter/material.dart';
import 'package:online_electronic_shopping_app/components/address.textfield.dart';
import 'package:online_electronic_shopping_app/service/userActivity/get_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hasSavedAddress = false;

  final nameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final localityController = TextEditingController();
  final flatnoController = TextEditingController();
  final landmarkController = TextEditingController();

  Future<void> _saveAddressToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the entered address details
    prefs.setString('name', nameController.text);
    prefs.setString('phoneNumber', phonenumberController.text);
    prefs.setString('pincode', pincodeController.text);
    prefs.setString('city', cityController.text);
    prefs.setString('state', stateController.text);
    prefs.setString('locality', localityController.text);
    prefs.setString('flatNo', flatnoController.text);
    prefs.setString('landmark', landmarkController.text);
    Provider.of<GetData>(context, listen: false).getAddressData();
  }

  // load from memory the address
  Future<void> loadAddressFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    nameController.text = prefs.getString('name') ?? '';
    phonenumberController.text = prefs.getString('phoneNumber') ?? '';
    pincodeController.text = prefs.getString('pincode') ?? '';
    cityController.text = prefs.getString('city') ?? '';
    stateController.text = prefs.getString('state') ?? '';
    localityController.text = prefs.getString('locality') ?? '';
    flatnoController.text = prefs.getString('flatNo') ?? '';
    landmarkController.text = prefs.getString('landmark') ?? '';
  }

  @override
  void initState() {
    super.initState();
    loadAddressFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add Address',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Info',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    AddressTextField(
                      label: 'Name',
                      maxlength: 35,
                      textEditingController: nameController,
                    ),
                    const SizedBox(height: 10),
                    AddressTextField(
                      label: 'Phone Number(+91)',
                      maxlength: 10,
                      textEditingController: phonenumberController,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address Info',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: AddressTextField(
                          label: 'Pincode',
                          maxlength: 6,
                          textEditingController: pincodeController,
                          textInputType: TextInputType.number,
                        )),
                        const SizedBox(width: 5),
                        Expanded(
                            child: AddressTextField(
                          label: 'City',
                          textEditingController: cityController,
                        ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    AddressTextField(
                        label: 'State', textEditingController: stateController),
                    const SizedBox(height: 10),
                    AddressTextField(
                      label: 'Locality/Area/Street',
                      textEditingController: localityController,
                    ),
                    const SizedBox(height: 10),
                    AddressTextField(
                        label: 'Flat no / Building Name',
                        maxlength: 30,
                        textEditingController: flatnoController),
                    const SizedBox(height: 10),
                    AddressTextField(
                        label: 'Landmark(optional)',
                        maxlength: 30,
                        textEditingController: landmarkController),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      _saveAddressToPreferences();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill out all required fields.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(500, 50)),
                  child: const Text(
                    'Save Address',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
