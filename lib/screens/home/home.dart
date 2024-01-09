import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forcast_task/screens/auth_page/auth_page.dart';
import 'package:weather_forcast_task/common/location_permission_page.dart';
import 'package:weather_forcast_task/screens/home/widgets/current_weather.dart';
import 'package:weather_forcast_task/screens/home/widgets/daily_forcast.dart';
import 'package:weather_forcast_task/models/current_weather.dart';
import 'package:weather_forcast_task/models/forecast.dart';
import 'package:weather_forcast_task/services/api_services.dart';
import 'package:weather_forcast_task/services/firebase_auth_service.dart';
import 'package:weather_forcast_task/services/internet_connectivity_service.dart';
import 'package:weather_forcast_task/services/permission_service.dart';
import 'package:weather_forcast_task/utils/helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Location location = Location();
  LocationData? currentLocation;

  List<Forecast> dailyForcastList = [];

  CurrentWeather? currentWeather;

  bool isLoaded = false;

  bool isConnectedToInternet = false;

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  Future<void> getLocation() async {
    try {
      final locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
      });
    } catch (e) {
      toast('Unable to get location');
    }
  }

  getWeatherData() async {
    setState(() {
      isLoaded = false;
      isConnectedToInternet = true;
    });
    bool isConnected =
        await InternetConnectivityService().checkInternetConnection();

    if (!isConnected) {
      setState(() {
        isConnectedToInternet = isConnected;
      });
      toast('No Internet Connection!');

      return;
    }

    bool isPermissionGranted = await PermissionService().getPermission();

    print('isPermissionGranted: $isPermissionGranted');

    if (isPermissionGranted) {
      await getLocation();
      await getDailyForecastData();

      await getCurrentForecast();

      setState(() {
        isLoaded = true;
      });
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (ctx) => const LocationPermissionPage()));

      toast("Permission not granted");
    }
  }

  getCurrentForecast() async {
    final lat = currentLocation!.latitude;

    final lon = currentLocation!.longitude;
    final forecastResponse = await ApiService().getData(
        '${ApiService().currentWeather}?units=metric&lat=$lat&lon=$lon');

    CurrentWeather currentWeatherData =
        CurrentWeather.fromJson(forecastResponse);

    setState(() {
      currentWeather = currentWeatherData;
    });
  }

  getDailyForecastData() async {
    final lat = currentLocation!.latitude;

    final lon = currentLocation!.longitude;
    final forecastResponse = await ApiService()
        .getData('${ApiService().forecast}?units=metric&lat=$lat&lon=$lon');

    List<dynamic> forcastResponseList = forecastResponse['list'];
    List<Forecast> forecastList =
        forcastResponseList.map((e) => Forecast.fromJson(e)).toList();

    setState(() {
      dailyForcastList = forecastList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: isLoaded ? customAppBar() : null,
      body: !isConnectedToInternet
          ? SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.signal_wifi_statusbar_connected_no_internet_4,
                        size: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text('No Interent Connection!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                      const SizedBox(
                        height: 28,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          getWeatherData();
                        },
                        child: Text(
                          'Retry',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      )
                    ]),
              ),
            )
          : !isLoaded
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () {
                      getWeatherData();
                      return Future.value();
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(top: 80),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            CurrentWeatherScreen(
                                currentWeather: currentWeather!),
                            const SizedBox(
                              height: 24,
                            ),
                            dailyForcastList.isEmpty
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    color: Colors.black.withOpacity(0.2),
                                    child: Column(
                                      children: [
                                        Text('Daily Weather',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white)),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        DailyForcastScreen(
                                            dailyForcastList: dailyForcastList),
                                      ],
                                    ),
                                  ),
                            const SizedBox(
                              height: 52,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  PreferredSizeWidget customAppBar() => AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          currentWeather!.placeName.toString(),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                await FirebaseAuthService().signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) => const AuthPage()));

                  prefs.setBool('isLoggedIn', false);

                  toast('User logged out');
                });
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      );
}
