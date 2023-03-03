import 'package:firebase_auth/firebase_auth.dart';
import 'auth_status.dart';

class AuthService {
  AuthStatus _status = AuthStatus.unknown;

  Future registration({required String email, required String password}) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        value.user!.sendEmailVerification();
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future login({required String email, required String password}) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user!.emailVerified) {
          return value;
        } else {
          await value.user!.sendEmailVerification();
          AuthService().signOut();
          throw FirebaseAuthException(
              code: 'Email-Not-Verified',
              message: 'Verification Email is sent. Please verify to continue');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signOut() async {
    await FirebaseAuth.instance.signOut();
    return 'User signed out';
  }

  // Future<User?> signInWithGoogle() async {
  //   await Firebase.initializeApp();
  //   User? user;
  //   GoogleAuthProvider authProvider = GoogleAuthProvider();
  //   try {
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithPopup(authProvider);
  //     user = userCredential.user;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }

  //   if (user != null) {}

  //   return user;
  // }

  // void signOutGoogle() async {
  //   GoogleSignIn googleSignIn = GoogleSignIn();

  //   await googleSignIn.signOut();
  //   await FirebaseAuth.instance.signOut();
  //   if (kDebugMode) {
  //     print("User signed out of Google account");
  //   }
  // }

  Future<AuthStatus> resetPassword({required String email}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }
}
