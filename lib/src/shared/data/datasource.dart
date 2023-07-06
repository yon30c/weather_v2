import 'package:dio/dio.dart';
import 'package:weather_v2/src/shared/classes/forecast.dart';

class Datasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'http://api.weatherapi.com/v1',
      queryParameters: {
        'key': '7609eb530dfb448fbc7162543230406',
        'lang': 'es',
      }));

  Future<Forecast> getCurrentWeather({String? city, double? lat, double? long}) async {
    final response = await dio
        .get('/forecast.json', queryParameters: {'q': city ?? '$lat,$long', 'days' : 3});

    final forecastResponse = Forecast.fromJson(response.data);

    return forecastResponse;
  }
}
