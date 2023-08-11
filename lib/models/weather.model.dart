class WeatherModel {
  int temp;
  WeatherModel({required this.temp});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(temp: json["temp"].toInt());
  }
  int getTemp() {
    return temp;
  }
}
