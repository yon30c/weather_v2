import 'package:flutter/material.dart';
import 'package:weather_v2/src/shared/classes/forecast.dart';
import 'package:date_format/date_format.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key, required this.forecast});

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(left: 10, child: _LeftSize(forecast)),
        Positioned(bottom: 10, right: 15, child: _Rightsize(forecast))
      ],
    );
  }
}

class _Rightsize extends StatelessWidget {
  const _Rightsize(this.forecast);

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Clima',
          style: textStyle.titleLarge,
        ),
        Text(
          formatDate(DateTime.parse(forecast.location.localtime.split(' ').first), [dd, '-', M, '-', yy]),
          style: textStyle.bodyLarge,
        ),
        Text(
          forecast.current.condition.text,
          style: textStyle.bodyLarge,
        )
      ],
    );
  }
}

class _LeftSize extends StatelessWidget {
  const _LeftSize(this.forecast);

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network('https:${forecast.current.condition.icon}'),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${forecast.current.tempC.toInt()}ºC',
                style: textStyle.headlineMedium,
              )
            ],
          ),
          Text(
            'Prob. de precipitaciones: ${forecast.current.precipIn}%',
            style: textStyle.bodyLarge,
          ),
          Text(
            'Humedad: ${forecast.current.humidity}%',
            style: textStyle.bodyLarge,
          ),
          Text(
            'viento: a ${forecast.current.windKph} km/h',
            style: textStyle.bodyLarge,
          ),
        ],
      ),
    );
  }
}
