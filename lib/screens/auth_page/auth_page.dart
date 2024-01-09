import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_forcast_task/screens/auth_page/widgets/login.dart';
import 'package:weather_forcast_task/screens/auth_page/widgets/signup.dart';
import 'package:weather_forcast_task/services/firebase_auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String bgImage =
      "https://i.pinimg.com/originals/b6/d9/a6/b6d9a63483cf501176e60a055bac7fc0.jpg";

  final _pageController = PageController();

  final _firebaseAuthService = FirebaseAuthService();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CachedNetworkImage(
                imageUrl: bgImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  // padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LoginPage(
                          emailController: emailController,
                          passwordController: passwordController,
                          firebaseAuthService: _firebaseAuthService,
                          moveToSignUpPage: () {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SignUpPage(
                          emailController: emailController,
                          passwordController: passwordController,
                          firebaseAuthService: _firebaseAuthService,
                          moveToLoginUpPage: () {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
