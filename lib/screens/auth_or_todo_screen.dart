import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/models/authenticated_user.dart';
import 'package:todo_app/screens/auth_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/loading_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:todo_app/services/auth_service.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key? key}) : super(key: key);

  // Inicializando o Firebase na aplicação
  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    // FutureBuilder do init para o Firebase inicializar com sucesso
    // antes de usar o app que é dependente desse serviço
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          // Stream Builder para ficar monitorando a mudança de autenticação
          // se o usuário fizer logout ou não estiver autenticado
          // irá exibir o HomeScreen
          return StreamBuilder<AuthenticatedUser?>(
            stream: AuthService().streamChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else {
                return snapshot.hasData
                    ? const TodoScreen()
                    : const HomeScreen();
              }
            },
          );
        }
      },
    );
  }
}
