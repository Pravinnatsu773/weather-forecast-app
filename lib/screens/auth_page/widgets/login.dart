// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forcast_task/screens/home/home.dart';
import 'package:weather_forcast_task/services/firebase_auth_service.dart';
import 'package:weather_forcast_task/services/internet_connectivity_service.dart';
import 'package:weather_forcast_task/services/permission_service.dart';
import 'package:weather_forcast_task/utils/helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(
      {super.key,
      required this.moveToSignUpPage,
      required this.firebaseAuthService,
      required this.emailController,
      required this.passwordController});

  final VoidCallback moveToSignUpPage;

  final FirebaseAuthService firebaseAuthService;

  final TextEditingController emailController;

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Welcome back!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 18,
        ),
        const Text(
          'Please enter your email and \n password to login.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: 'Enter your email',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Enter your password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  if (!isEmail(emailController.text)) {
                    toast('Enter a valid email');
                    return;
                  }
                  if (passwordController.text.length < 8) {
                    toast('Password must be altleast 8 characters long');
                    return;
                  }

                  bool isConnected = await InternetConnectivityService()
                      .checkInternetConnection();

                  if (isConnected) {
                    await firebaseAuthService
                        .signInWithEmailAndPassword(
                            emailController.text, passwordController.text)
                        .then((response) {
                      if (response == 'Success') {
                        prefs.setBool('isLoggedIn', true);

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => const Home()));
                      }else{
                         prefs.setBool('isLoggedIn', false);
                      }
                    });
                  } else {
                    toast("No internet connection");
                    return;
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  // width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.deepPurple),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        RichText(
            text: TextSpan(
                text: 'Don\'t have an account? ',
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: 'Sign up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => moveToSignUpPage(),
                  style: const TextStyle(color: Colors.deepPurple))
            ]))
      ],
    );
  }
}
