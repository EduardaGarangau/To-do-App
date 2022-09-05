import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/auth_screen.dart';
import 'package:todo_app/screens/loading_screen.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:todo_app/services/todo_list_service.dart';
import 'package:todo_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            })),
        home: const SplashScreen(),
        routes: {
          AppRoutes.AUTH_SCREEN: (context) => const AuthScreen(),
          AppRoutes.TODO_SCREEN: (context) => const TodoScreen(),
        },
      ),
    );
  }
}
