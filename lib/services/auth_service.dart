import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_app/models/authenticated_user.dart';

class AuthService {
  static AuthenticatedUser? _currentUser;

  // Stream que monitora a mudança de autenticação do usuário no Firebase Auth
  static final _streamChanges =
      Stream<AuthenticatedUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user != null
          ? AuthenticatedUser(
              id: user.uid,
              name: user.displayName ?? user.email!.split('@')[0],
              email: user.email!,
              imageURL: user.photoURL ?? '',
            )
          : null;
      controller.add(_currentUser);
    }
  });

  // Método get para pegar a Stream com as mudanças de autenticação do usuário
  Stream<AuthenticatedUser?> get streamChanges {
    return _streamChanges;
  }

  // Método get para pegar o usuário autenticado
  AuthenticatedUser? get currentUser {
    return _currentUser;
  }

  // Fazendo Sign Up no Firebase Auth
  Future<void> signUp(
      String name, String password, String email, File? image) async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      return;
    }

    // Criando o nome e armazenando a imagem no Firebase Storage
    // Armazenando numa variável a URL da imagem persistida
    final imageName = '${credential.user!.uid}.jpg';
    final imageURL = await _uploadUserImage(image, imageName);

    // Criando o name e a PhotoURL do usuário autenticado
    await credential.user!.updateDisplayName(name);
    await credential.user!.updatePhotoURL(imageURL);

    // Cria um currentUser com a autenticação do usuário
    _currentUser = AuthenticatedUser(
      id: credential.user!.uid,
      name: name,
      email: email,
      imageURL: imageURL!,
    );
  }

  // Método usado para armazenar a imagem do usuário no Firebase Storage
  // Dentro de user_images ficará armazenado a imagem com o nome da uid do usuário
  // Irá retornar a URL de onde a imagem está armazenada
  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) {
      return null;
    }

    final storage = FirebaseStorage.instance;
    // Faz referência ao bucket de arquivos, pasta user_images e a imagem que será persistida
    final imageRef = storage.ref().child('user_images').child(imageName);
    // Espera a imagem ser persistida no Storage
    await imageRef.putFile(image).whenComplete(() => {});
    // Retorna a URL da imagem armazenada no Storage
    return await imageRef.getDownloadURL();
  }

  // Fazer login no Firebase Auth
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Fazer o logout no Firebase Auth
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
