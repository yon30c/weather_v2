import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_v2/src/shared/data/datasource.dart';

final forecastProvider = FutureProvider((ref) =>
    Datasource().getCurrentWeather(
        city: ref.watch(cityProvider),
        lat: ref.watch(latitudProvider),
        long: ref.watch(longitudProvider)));

final cityProvider = StateProvider<String?>((ref) => null);
final latitudProvider = StateProvider<double?>((ref) => null);
final longitudProvider = StateProvider<double?>((ref) => null);
