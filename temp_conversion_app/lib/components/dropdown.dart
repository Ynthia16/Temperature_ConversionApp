import 'package:flutter/material.dart';

const List<String> list = <String>['Fahrenheit', 'Celsius'];

class DropdownMenuExample extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String?> onChanged;

  const DropdownMenuExample(
      {required this.initialValue, required this.onChanged, super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        widget.onChanged(newValue);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
