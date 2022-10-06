import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<User?, FirebaseAuthException>> userLogin(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Left(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return Right(e);
    }
  }
}
