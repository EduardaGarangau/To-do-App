import 'package:flutter/material.dart';
import 'package:todo_app/widgets/login_button.dart';
import 'package:todo_app/widgets/sign_up_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            child: Column(
              children: [
                const SizedBox(height: 180),
                Image.asset(
                  'lib/assets/images/logo_2.png',
                  height: 180,
                ),
                const SizedBox(height: 150),
                Stack(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(
                              MediaQuery.of(context).size.width, 100.0)),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.378,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(4, 89, 165, 1),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 100.0)),
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.08,
                      top: MediaQuery.of(context).size.height * 0.04,
                      child: Column(
                        children: const [
                          SizedBox(height: 40),
                          SizedBox(
                            width: 350,
                            child: Text(
                              'Welcome to your favorite To-Do App, we never let you forget anything! ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(5.0, 5.0),
                                  ),
                                ],
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 35),
                          SignUpButton(),
                          SizedBox(height: 10),
                          LoginButton(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
