import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider_app/Authentication/registration_screen.dart';
import 'package:rider_app/allWidgets/progress_dialog.dart';

import '../Screens/home_screen.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  //create a route
  static const String idScreen = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController _emailTextEditingController = TextEditingController();
TextEditingController _passwordTextEditingController = TextEditingController();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('Assets/images/taxi.jpg')),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            'Login as a Rider',
            style: GoogleFonts.getFont('Dancing Script',
                textStyle: const TextStyle(
                    fontSize: 40, color: Color.fromRGBO(190, 5, 73, 0.983))),
          ),
        ),
        //creating a column of widgets for our form fields
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordTextEditingController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    _validateAndLoginUser(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationScreen.idScreen, (route) => false);
                  },
                  child: const Text('Do not have an account? Register Here'))
            ],
          ),
        ),
      ]),
    );
  }
}

Future _validateAndLoginUser(context) async {
  if (!_emailTextEditingController.text.contains("@")) {
    displayToastMessage("Email address is invalid", context);
  } else if (_emailTextEditingController.text.length < 6) {
    displayToastMessage("Password is too short", context);
  } else {
    loginUser(context);
  }
}

//Function to Sign in user
void loginUser(context) async {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const ProgressDialog(
          message: "Authenticating, Please wait...",
        );
      });

  final User? firebaseUser = (await _firebaseAuth
          .signInWithEmailAndPassword(
              email: _emailTextEditingController.text,
              password: _passwordTextEditingController.text)
          .catchError((errorMsg) {
    Navigator.pop(context);
    displayToastMessage('Error' + errorMsg.toString(), context,
        color: Colors.red);
  }))
      .user;

  if (firebaseUser != null) {
    userRef.child(firebaseUser.uid).once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.idScreen, (route) => false);
        //clear the user details from the controllers:
        clearTextEditingControllers();
        displayToastMessage('You are logged-in', context, color: Colors.green);
      } else {
        _firebaseAuth.signOut();
        Navigator.pop(context);
        displayToastMessage(
            "No record exist for this user, please create account", context,
            color: Colors.red);
      }
    });
  } else {
    Navigator.pop(context); //to remove the progress dialog indicator
    displayToastMessage("error occured cannot be signed in", context,
        color: Colors.red);
  }
}

//to display flutter toast
displayToastMessage(String message, BuildContext context, {Color? color}) {
  Fluttertoast.showToast(msg: message, backgroundColor: color);
}

//cleart text edting controllers:
clearTextEditingControllers() {
  // _emailTextEditingController.clear();
  _passwordTextEditingController.clear();
}
