import 'package:card_swiper/card_swiper.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../shared/views/weather_view.dart';
import '../../providers/forecast_provider.dart';
import '../../providers/position_provider.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'Home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  late Position position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosition();
  }

  getPosition() async {
    position = await determinePosition();

    ref.read(latitudProvider.notifier).update((state) => position.latitude);
    ref.read(longitudProvider.notifier).update((state) => position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    final weather = ref.watch(forecastProvider);

    String? day;
    // var localizationDelegate = LocalizedApp.of(context).delegate;

    return weather.when(
        data: (data) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                  centerTitle: true,
                  title: Text(
                    data.location.name,
                    style: TextStyle(color: color.onBackground),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                        width: double.infinity,
                        height: size.height * 0.3,
                        child: WeatherView(
                          forecast: data,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Pronostico',
                            style: textStyle.titleLarge
                                ?.copyWith(color: color.primary),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Swiper(
                              viewportFraction: 0.3,
                              autoplay: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  data.forecast.forecastday[0].hour.length,
                              itemBuilder: (context, index) {
                                final forecast =
                                    data.forecast.forecastday[0].hour[index];

                                return CsGridTile(
                                    header: Text(
                                      formatDate(DateTime.parse(forecast.time),
                                          [HH, ':', nn]),
                                      style: textStyle.titleMedium,
                                    ),
                                    footer: Text(
                                      '${forecast.tempC.toInt()}ºC',
                                      style: textStyle.titleSmall,
                                    ),
                                    child: Image.network(
                                        'https:${forecast.condition.icon}'));
                              }),
                        ),
                      ],
                    ),
                  ],
                )),
                SliverList.builder(
                    itemCount: data.forecast.forecastday.length,
                    itemBuilder: (context, index) {
                      final forecast = data.forecast.forecastday[index];
                      switch (formatDate(forecast.date, [DD])) {
                        case 'Monday':
                          day = 'Lunes';
                          break;
                        case 'Tuesday':
                          day = 'Martes';
                          break;
                        case 'Wednesday':
                          day = 'Miércoles';
                          break;
                        case 'Thursday':
                          day = 'Jueves';
                          break;
                        case 'Friday':
                          day = 'Viernes';
                          break;
                        case 'Saturday':
                          day = 'Sábado';
                          break;
                        case 'Sunday':
                          day = 'Domingo';
                          break;
                        default:
                      }
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Text(
                              day!,
                              textAlign: TextAlign.center,
                              style: textStyle.titleMedium,
                            ),
                            subtitle: Text(
                                'Min ${forecast.day.mintempC.toInt()}ºC - Max ${forecast.day.maxtempC.toInt()}ºC',
                                textAlign: TextAlign.center),
                            leading: Image.network(
                                'https:${forecast.day.condition.icon}')),
                      );
                    })
              ],
            ),
        error: (error, __) => Text('Error $error'),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class CsGridTile extends StatelessWidget {
  const CsGridTile(
      {super.key,
      required this.header,
      required this.footer,
      required this.child});

  final Widget? header;
  final Widget? footer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.primaryContainer,
      ),
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (header != null) header!,
          const SizedBox(
            height: 5,
          ),
          child,
          const SizedBox(
            height: 5,
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
