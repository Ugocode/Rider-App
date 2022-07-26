import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rider_app/Authentication/login_screen.dart';

import '../Screens/home_screen.dart';
import '../main.dart';
//import 'firebase_authetication.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  //create a route
  static const String idScreen = 'Register';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

TextEditingController _nameTextEditingController = TextEditingController();
TextEditingController _phoneTextEditingController = TextEditingController();
TextEditingController _emailTextEditingController = TextEditingController();
TextEditingController _passwordTextEditingController = TextEditingController();

//FirebaseAuthentication? _firebaseController;

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _RegistrationScreenState extends State<RegistrationScreen> {
//for registering new user

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
            'Register as a Rider',
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
                controller: _nameTextEditingController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _phoneTextEditingController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
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
                    //call registration function
                    setState(() {
                      _validationAndRegistration(context);
                      //registerNewUser(context);
                    });
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.idScreen, (route) => false);
                  },
                  child: const Text('Already have an account?  Login Here'))
            ],
          ),
        ),
      ]),
    );
  }

  Future _validationAndRegistration(BuildContext context) async {
    if (_nameTextEditingController.text.length < 4) {
      displayToastMessage("Name must be atleast 3 characters.", context);
    } else if (!_emailTextEditingController.text.contains("@")) {
      displayToastMessage("Email address is invalid", context);
    } else if (_passwordTextEditingController.text.length < 6) {
      displayToastMessage("Password lenght is too short", context);
    } else if (_phoneTextEditingController.text.isEmpty) {
      displayToastMessage("Phone field cannot be empty", context);
    } else {
      registerUser(context);
      // .then((value) async {
      //   await clearTextEditingControllers();
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, HomePage.idScreen, (route) => false);
      //  });
    }
  }

//registration of users
  void registerUser(
    BuildContext context,
  ) async {
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextEditingController.text,
                password: _passwordTextEditingController.text)
            .catchError((errorMsg) {
      displayToastMessage('Error' + errorMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      //save user to database:
      Map userDataMap = {
        "name": _nameTextEditingController.text.trim(),
        "phone": _phoneTextEditingController.text.trim(),
        "email": _emailTextEditingController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);

      displayToastMessage(
          "Congratulations, your account has been created", context);

      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.idScreen, (route) => false);
    } else {
      //error occured
      displayToastMessage(
          "Sorry Error occured your account has NOT been created", context);
    }
  }

//to display flutter toast
  displayToastMessage(String message, BuildContext context, {Color? color}) {
    Fluttertoast.showToast(msg: message, backgroundColor: color);
  }

// //making the function to register user:
//   Future registerNewUser() async {
//     _firebaseController?.registerUser(
//         context,
//         _emailTextEditingController.text.trim(),
//         _passwordTextEditingController.text.trim(),
//         _nameTextEditingController.text.trim(),
//         _phoneTextEditingController.text.trim());
//   }

//   //cleart text edting controllers:
//   clearTextEditingControllers() {
//     _emailTextEditingController.clear();
//     _passwordTextEditingController.clear();
//     _nameTextEditingController.clear();
//     _phoneTextEditingController.clear();
//   }
}
