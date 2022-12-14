import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hyjoden/models/user_model.dart';
import 'package:hyjoden/services/database_service.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final DatabaseService _databaseService;

  AuthService({required DatabaseService dbService})
      : _databaseService = dbService;

  Future<User?> currentUser() async {
    return await _databaseService.getUserFromUid(
        uid: _firebaseAuth.currentUser?.uid);
  }

  Future<User?> signInWithEmailAndPassword(
      {required email, required password}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email!, password: password!);
    final userUid = userCredential.user?.uid;
    final user = await _databaseService.getUserFromUid(uid: userUid);
    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    return;
  }

  Future<User> createUser({
    required email,
    required username,
    required password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (userCredential.user == null) {
      throw Exception('create user with email and password return null');
    }

    final firebaseUser = userCredential.user;
    final newUser = User(
      uid: firebaseUser!.uid,
      email: email,
      username: username,
    );

    _databaseService.createUserFromModel(user: newUser);

    return newUser;
  }

  Stream<User?>? get userStream {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      return await _databaseService.getUserFromUid(uid: firebaseUser?.uid);
    });
  }
}
