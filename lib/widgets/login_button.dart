import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/models/auth_model.dart';
import 'package:todo_app/utils/app_routes.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        children: const [
          Text(
            'Already have an account?',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSans',
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(width: 5),
          Text(
            'Log in',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.AUTH_SCREEN, arguments: AuthMode.Login);
      },
    );
  }
}
