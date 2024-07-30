import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/app/screens/settings/pages/calculator/bloc/calculator_bloc.dart';

class CalculatorTextField extends StatelessWidget {
  final String title;
  final List<String>? dropdownData;
  final Function(String value)? dropdownChanged;
  final String? dropdownValue;
  final String? hintText;
  final TextEditingController controller;
  const CalculatorTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.dropdownValue,
      this.dropdownChanged,
      this.dropdownData,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 8.0), // Adjust padding as needed
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    controller: controller,
                    cursorColor:
                        (Theme.of(context).brightness == Brightness.light)
                            ? Colors.black
                            : Colors.white,
                    decoration: InputDecoration(
                      hintText: (hintText != null) ? hintText : null,
                      contentPadding: const EdgeInsets.all(0),
                      hoverColor: Colors.blue,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {},
                  ),
                ),
              ),
              (dropdownData == null)
                  ? Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    )
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          items: dropdownData!.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            BlocProvider.of<CalculatorBloc>(context).add(
                                CalculatorChangeDropdownValue(
                                    value: val.toString()));
                          },
                        ),
                      ],
                    )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Divider(
                color: (Theme.of(context).brightness == Brightness.light)
                    ? Colors.black
                    : Colors.white),
          )
        ],
      ),
    );
  }
}
