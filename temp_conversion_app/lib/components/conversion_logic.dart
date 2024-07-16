
class TemperatureConverter {
  static String convertTemperature(String conversionType, double inputValue) {
    double converted;
    if (conversionType == 'F to C') {
      converted = (inputValue - 32) * 5 / 9;
    } else {
      converted = (inputValue * 9 / 5) + 32;
    }
    return converted.toStringAsFixed(2);
  }
}

class ConversionHistory {
  final List<String> _history = [];

  List<String> get history => _history;

  void addConversion(
      String conversionType, double inputValue, String convertedValue) {
    _history.add('$conversionType: $inputValue => $convertedValue');
  }
}
