import 'package:flutter/material.dart';
import 'package:weather_forcast_task/screens/home/home.dart';
import 'package:weather_forcast_task/services/permission_service.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.location_pin,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
                'Please turn on location permission \nfor getting weather data',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white)),
            const SizedBox(
              height: 46,
            ),
            ElevatedButton(
                onPressed: () async {
                  bool isPermissionGranted =
                      await PermissionService().getPermission();
                  if (isPermissionGranted) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => const Home()));
                  }
                },
                child: Text(
                  'Allow access',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ))
          ]),
        ),
      ),
    );
  }
}
