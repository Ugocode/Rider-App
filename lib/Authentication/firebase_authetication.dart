// import 'package:firebase_auth/firebase_auth.dart';

// //import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rider_app/Screens/home_screen.dart';

// import '../main.dart';

// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// // final DatabaseReference userRef =
// //     FirebaseDatabase.instance.ref().child('users');

// class FirebaseAuthentication {
//   Future registerUser(BuildContext context, String email, String password,
//       String name, String phoneNumber) async {
//     final User? firebaseUser = (await _firebaseAuth
//             .createUserWithEmailAndPassword(email: email, password: password)
//             .catchError((errorMsg) {
//       displayToastMessage('Error' + errorMsg.toString(), context);
//     }))
//         .user;
//     if (firebaseUser != null) {
//       Map userDataMap = {
//         "name": name,
//         "phone": phoneNumber,
//         "email": email,
//       };

//       await userRef.child(firebaseUser.uid).set(userDataMap);
//       displayToastMessage(
//           "Congratulations, your account has been created", context);

//       Navigator.pushNamedAndRemoveUntil(
//           context, HomePage.idScreen, (route) => false);
//     } else {
//       //error occured
//       displayToastMessage(
//           "Sorry Error occured your account has NOT been created", context);
//     }
//   }

//   //to display flutter toast
//   displayToastMessage(String message, BuildContext context) {
//     Fluttertoast.showToast(msg: message);
//   }
// }
