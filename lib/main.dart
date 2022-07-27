import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/Authentication/login_screen.dart';

import 'Authentication/registration_screen.dart';
import 'Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

DatabaseReference userRef = FirebaseDatabase(
        databaseURL:
            'https://riderapp-79654-default-rtdb.europe-west1.firebasedatabase.app/')
    .ref()
    .child('users');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(115, 2, 44, 2),
          primarySwatch: Colors.pink),
      //creating Routes for our app
      initialRoute: LoginScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen: ((context) => const RegistrationScreen()),
        LoginScreen.idScreen: ((context) => const LoginScreen()),
        HomePage.idScreen: ((context) => HomePage())
      },
    );
  }
}
