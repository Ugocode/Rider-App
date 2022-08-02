import 'package:flutter/material.dart';
import 'package:rider_app/Screens/home_screen.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  //create a route
  static String idScreen = 'AboutUs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomePage.idScreen, (route) => false);
            },
            child: const Icon(Icons.backspace_sharp)),
      ),
    );
  }
}
