import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_conversion_app/components/button.dart';
import 'package:temp_conversion_app/components/dropdown.dart';
import 'package:temp_conversion_app/components/conversion_logic.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  String _selectedConversionFrom = 'Fahrenheit';
  String _selectedConversionTo = 'Celsius';
  double _inputValue = 0.0;
  dynamic _convertedValue = 0.0;
  final ConversionHistory _conversionHistory = ConversionHistory();

  void _convert() {
    String conversionType =
        _selectedConversionFrom == 'Fahrenheit' ? 'F to C' : 'C to F';
    dynamic convertedValue =
        TemperatureConverter.convertTemperature(conversionType, _inputValue);
    setState(() {
      _convertedValue = convertedValue;
      _conversionHistory.addConversion(
          conversionType, _inputValue, _convertedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(197, 118, 41, 132),
              Color.fromARGB(255, 32, 255, 184),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 450
                        : 350,
                width: 400,
                child: Card(
                  color: Colors.white.withOpacity(0.2),
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Temperature Converter',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Enter the temperature',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.8)),
                        ),
                        TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 220, 220, 220)),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(14, 14)),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(15, 3, 0, 0),
                            hintText: 'Enter the temperature',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 220, 220, 220),
                                fontSize: 15),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _inputValue = double.tryParse(value) ?? 0.0;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('From',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            Text('To',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownMenuExample(
                              initialValue: _selectedConversionFrom,
                              onChanged: (value) {
                                setState(() {
                                  _selectedConversionFrom = value!;
                                });
                              },
                            ),
                            const Icon(Icons.swap_horiz, color: Colors.white),
                            DropdownMenuExample(
                              initialValue: _selectedConversionTo,
                              onChanged: (value) {
                                setState(() {
                                  _selectedConversionTo = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Center(child: MyButton(onPressed: _convert)),
                        SizedBox(height: 10),
                        Center(
                          child: Row(
                            children: [
                              Text(
                                'Converted Value: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              Text(
                                _convertedValue.toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Conversion History:',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _conversionHistory.history.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _conversionHistory.history[index],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
