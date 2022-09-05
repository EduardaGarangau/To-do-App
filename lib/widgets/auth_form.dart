import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/models/auth_model.dart';
import 'package:todo_app/widgets/image_signup.dart';

class AuthForm extends StatefulWidget {
  final AuthMode authMode;
  final void Function(AuthModel) onSubmit;

  const AuthForm({
    required this.onSubmit,
    required this.authMode,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _authModel = AuthModel();
    final passwordController = TextEditingController();

    void handleImagePicked(File image) {
      _authModel.image = image;
    }

    void _submitForm() {
      final isValid = _formKey.currentState?.validate() ?? false;

      if (!isValid) {
        return;
      }

      if (_authModel.image == null && _authModel.isSignup) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Choose an Photo'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }

      FocusManager.instance.primaryFocus?.unfocus();
      widget.onSubmit(_authModel);
      // Navigator para sair da tela de formulário e ir para TodoScreen
      // sem isso irá ficar parado no formulário por conta do StreamBuilder
      // por conta do HomePage caso snapshot.hasNoData
      Timer(
        const Duration(seconds: 1),
        () => Navigator.of(context).pop(),
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            if (widget.authMode == AuthMode.Signup)
              ImageSignup(onPickedImage: handleImagePicked),
            if (widget.authMode == AuthMode.Signup) const SizedBox(height: 10),
            if (widget.authMode == AuthMode.Signup)
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (name) => _authModel.name = name,
                validator: (nameValidator) {
                  final name = nameValidator ?? '';

                  if (name.trim().length < 5) {
                    return 'Please inform your name';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
                hintText: 'E-mail',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (email) => _authModel.email = email,
              validator: (emailValidator) {
                final email = emailValidator ?? '';

                if (!email.contains('@')) {
                  return 'Please inform a valid E-mail';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
              controller: passwordController,
              onChanged: (password) => _authModel.password = password,
              validator: (passwordValidator) {
                final password = passwordValidator ?? '';

                if (password.trim().isEmpty) {
                  return 'Please inform an password';
                } else if (password.trim().length < 8) {
                  return 'Please inform an password with at least 8 caracters';
                }
                return null;
              },
            ),
            if (widget.authMode == AuthMode.Signup) const SizedBox(height: 10),
            if (widget.authMode == AuthMode.Signup)
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  hintText: 'Confirm Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                obscureText: true,
                validator: (confirmValidator) {
                  final confirmPassword = confirmValidator ?? '';

                  if (confirmPassword != passwordController.text) {
                    return 'Different password';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    child: const Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    child: Text(
                      widget.authMode == AuthMode.Signup
                          ? 'REGISTER'
                          : 'LOG IN',
                    ),
                    onPressed: _submitForm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
