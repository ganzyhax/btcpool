import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final Function(String? value)? function;
  final String selectedValue;
  final List<DropdownMenuItem<String>> items;
  const CustomDropdownButton(
      {super.key,
      required this.selectedValue,
      this.function,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
        ),
        dropdownColor: Theme.of(context).colorScheme.secondary,
        value: selectedValue,
        onChanged: function,
        items: items);
  }
}
