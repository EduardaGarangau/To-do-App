import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/auth_or_todo_screen.dart';
import 'package:todo_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AuthOrHomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 900),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage('lib/assets/images/background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Image.asset(
              'lib/assets/images/logo_2.png',
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
