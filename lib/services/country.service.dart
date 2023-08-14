import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class CountryService {
  static Future<double> getTemperature({String city = "kigali"}) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=${city.toLowerCase()}&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      double temp = jsonDecode(response.body)["main"]["temp"];
      return temp;
    }
    return 0.0;
  }
}
