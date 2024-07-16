import 'package:flutter/material.dart';
import 'package:temp_conversion_app/components/card.dart';

void main() => runApp(TemperatureConversionApp());

class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyCard(),
    );
  }
}
