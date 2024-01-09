import 'package:flutter/material.dart';
import 'package:weather_forcast_task/models/current_weather.dart';
import 'package:weather_forcast_task/utils/helper.dart';

class CurrentWeatherScreen extends StatelessWidget {
  const CurrentWeatherScreen({super.key, required this.currentWeather});
  final CurrentWeather currentWeather;
  @override
  Widget build(BuildContext context) {
    final date = convertToDateTime(currentWeather.dt);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentWeather.feels_like.toString(),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'deg',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text('Today ${date.split(' ').last}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.normal, color: Colors.white)),
        const SizedBox(
          height: 52,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.black.withOpacity(0.2),
          // height: 200,
          child: Column(
            children: [
              Text('Today',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.normal, color: Colors.white)),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Feels like',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  Text(currentWeather.feels_like.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white))
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Temp min',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  Text(currentWeather.temp_min.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white))
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Temp max',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  Text(currentWeather.temp_max.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white))
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pressure',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  Text(currentWeather.pressure.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white))
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Humidity',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  Text(currentWeather.humidity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white))
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Wind speed',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  Text(currentWeather.wind_speed.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
