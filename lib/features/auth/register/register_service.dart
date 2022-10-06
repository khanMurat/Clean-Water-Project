import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<User?, FirebaseAuthException>> registerUser(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return Left(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Right(e);
    }
  }
}
