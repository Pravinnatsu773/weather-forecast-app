import 'package:flutter/material.dart';
import 'package:weather_forcast_task/screens/home/widgets/detailed_weather.dart';
import 'package:weather_forcast_task/models/forecast.dart';
import 'package:weather_forcast_task/utils/helper.dart';

class DailyForcastScreen extends StatelessWidget {
  const DailyForcastScreen({super.key, required this.dailyForcastList});

  final List<Forecast> dailyForcastList;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: dailyForcastList.map((e) {
      final date = convertToDateTime(e.dt);
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              // print(e);
              showDetailedWeather(e, date, context);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 4,
          ),
        ],
      );
    }).toList());
  }

  showDetailedWeather(Forecast weatherData, date, context) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return DetailedWeather(weatherData: weatherData, date: date);
        },
      );
}
