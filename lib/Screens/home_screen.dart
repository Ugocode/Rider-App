import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  //create a route
  static const String idScreen = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Haah its Working!',
          style: GoogleFonts.getFont('Lato'),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(),
    );
  }
}
