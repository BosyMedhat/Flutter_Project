import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await userCredential.user!.updateDisplayName(username);
      
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak';
        case 'email-already-in-use':
          return 'An account already exists for that email';
        case 'invalid-email':
          return 'The email address is invalid';
        default:
          return 'An error occurred. Please try again';
      }
    } catch (e) {
      return 'An error occurred. Please try again';
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email';
        case 'wrong-password':
          return 'Wrong password provided';
        case 'invalid-email':
          return 'The email address is invalid';
        case 'user-disabled':
          return 'This account has been disabled';
        default:
          return 'An error occurred. Please try again';
      }
    } catch (e) {
      return 'An error occurred. Please try again';
    }
  }

  Future<String?> updateEmail(String newEmail) async {
    try {
      await currentUser!.verifyBeforeUpdateEmail(newEmail);
      await _firestore.collection('users').doc(currentUser!.uid).update({
        'email': newEmail,
      });
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return 'Please log in again to update your email';
        case 'email-already-in-use':
          return 'This email is already in use';
        case 'invalid-email':
          return 'The email address is invalid';
        default:
          return 'Failed to update email';
      }
    } catch (e) {
      return 'An error occurred. Please try again';
    }
  }

  Future<String?> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: currentPassword,
      );
      
      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return 'Current password is incorrect';
        case 'weak-password':
          return 'The new password is too weak';
        default:
          return 'Failed to update password';
      }
    } catch (e) {
      return 'An error occurred. Please try again';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> getUsername() async {
    try {
      final doc = await _firestore.collection('users').doc(currentUser!.uid).get();
      return doc.data()?['username'] as String?;
    } catch (e) {
      return currentUser?.displayName;
    }
  }
}