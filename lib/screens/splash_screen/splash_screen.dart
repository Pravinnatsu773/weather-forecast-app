import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forcast_task/screens/auth_page/auth_page.dart';
import 'package:weather_forcast_task/screens/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String bgImage =
      "https://i.pinimg.com/originals/b6/d9/a6/b6d9a63483cf501176e60a055bac7fc0.jpg";

  checkIfAlreadyLoggedIn(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const Home()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const AuthPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkIfAlreadyLoggedIn(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: CachedNetworkImage(
          imageUrl: bgImage,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
