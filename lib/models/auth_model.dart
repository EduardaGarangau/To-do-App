import 'dart:io';

enum AuthMode {
  Signup,
  Login,
}

// Classe que será usado como modelo para salvar dados do usuário
// via formulário, por isso não precisa de construtor, não irá criar objeto
class AuthModel {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.Login;

  bool get isLogin {
    return _mode == AuthMode.Login;
  }

  bool get isSignup {
    return _mode == AuthMode.Signup;
  }
}
