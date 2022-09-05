import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/utils/app_routes.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Drawer(
      width: 250,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(2, 23, 50, 1),
                    Color.fromRGBO(4, 60, 117, 1),
                    Color.fromRGBO(4, 89, 165, 1),
                    Color.fromRGBO(6, 155, 216, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 110),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user!.imageURL,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 14,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.TODO_SCREEN),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => AuthService().logout(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
