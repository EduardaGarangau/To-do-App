import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const LinearProgressIndicator(
                    minHeight: 7,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSans',
                    letterSpacing: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
