import 'package:flutter/material.dart';
import 'package:todo_app/models/auth_model.dart';
import 'package:todo_app/utils/app_routes.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.AUTH_SCREEN, arguments: AuthMode.Signup);
      },
      child: Container(
        width: 280,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.email,
              color: Colors.black,
            ),
            SizedBox(width: 7),
            Text(
              'Sign Up with E-mail',
              style: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
