import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField(
      {super.key,
      required this.label,
      this.maxlength,
      required this.textEditingController,
      this.textInputType,
      this.errormessage});

  final String label;
  final int? maxlength;
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final String? errormessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      controller: textEditingController,
      maxLength: maxlength,
      keyboardType: textInputType,
      decoration: InputDecoration(labelText: label, counterText: ''),
    );
  }
}
