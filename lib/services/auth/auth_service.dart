import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,

        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  // save

  //sign up
  Future<UserCredential> signUpWithEmailPassword(
    String email,

    password,
    String username,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // save
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      
      
  
      throw Exception(e.code);
    }
  }
  // save

  // sign out
  Future<void> signout() async {
    return await _auth.signOut();
  }

  // catch any err
  // void registerUser(
  //   BuildContext context,
  //   String email,
  //   String password,
  //   String username,
  // ) async {
  //   final authService = AuthService();

  //   try {
  //     await authService.signUpWithEmailPassword(email, password, username);
  //     // Optional: Navigate or show success message
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder:
  //           (context) => AlertDialog(
  //             title: const Text("Error"),
  //             content: Text(e.toString()),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text("OK"),
  //               ),
  //             ],
  //           ),
  //     );
  //   }
  // }
}
