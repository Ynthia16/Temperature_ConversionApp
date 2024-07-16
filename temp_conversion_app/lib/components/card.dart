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
  String _convertedValue = '';
  final ConversionHistory _conversionHistory = ConversionHistory();

  void _convert() {
    String conversionType =
        _selectedConversionFrom == 'Fahrenheit' ? 'F to C' : 'C to F';
    String converted =
        TemperatureConverter.convertTemperature(conversionType, _inputValue);
    setState(() {
      String unit = _selectedConversionTo == 'Fahrenheit' ? '°F' : '°C';
      _convertedValue = "${double.parse(converted).toStringAsFixed(1)} $unit";
      _conversionHistory.addConversion(
          conversionType, _inputValue, _convertedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        decoration: const BoxDecoration(
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
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          // margin:Edg,
          child: Center(
            child: SizedBox(
              height: 450,
              width: 400,
              child: Card(
                color: Colors.white.withOpacity(0.2),
                elevation: 10,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Temperature Converter',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(223, 255, 255, 255)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Temperature',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 213, 213, 213)),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          hintText: 'Enter the temperature',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 220, 220, 220),
                              fontSize: 14),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _inputValue = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('From',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          Text('To',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 4),
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
                      const SizedBox(height: 15),
                      Center(child: MyButton(onPressed: _convert)),
                      const SizedBox(height: 10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Converted Value: ',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            Text(_convertedValue,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Conversion History:',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _conversionHistory.history.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white.withOpacity(0.4),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      _conversionHistory.history[index],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
