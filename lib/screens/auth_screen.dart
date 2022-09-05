import 'package:flutter/material.dart';
import 'package:todo_app/models/auth_model.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authMode = ModalRoute.of(context)!.settings.arguments as AuthMode;

    void submitForm(AuthModel authModel) {
      if (authMode == AuthMode.Signup) {
        AuthService().signUp(
          authModel.name,
          authModel.password,
          authModel.email,
          authModel.image,
        );
      } else {
        AuthService().login(
          authModel.email,
          authModel.password,
        );
      }
    }

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
            child: SingleChildScrollView(
              child: Container(
                height: authMode == AuthMode.Signup ? 570 : 330,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      authMode == AuthMode.Signup ? 'Sign Up' : 'Log In',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSans',
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                    // Passa o AuthMode para o formulário para mostrar os campos corretos
                    // dependendo do modo de autenticação do usuário.
                    // Passa a função submitForm para fazer uma comunicação indireta
                    // o Form (filho) passar dados para o AuthScren (pai) fazer a autenticação
                    AuthForm(authMode: authMode, onSubmit: submitForm),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
