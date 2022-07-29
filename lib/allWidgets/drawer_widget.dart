// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rider_app/Screens/about_us.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 225,
      child: Drawer(
        // backgroundColor: Colors.blueGrey[200],
        child: ListView(
          children: [
            Container(
              color: Colors.grey,
              height: 105,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.pink),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'Assets/images/taxi.jpg',
                        height: 65,
                        width: 65,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Profile Name',
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: 'Brand-Bold'),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 10.0),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Drawer body cntrollers
            const SizedBox(
              height: 12,
            ),
            const ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payments'),
            ),
            const ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
            ),
            const ListTile(
              leading: Icon(Icons.tag),
              title: Text('Promotions'),
            ),
            const ListTile(
              leading: Icon(Icons.chat),
              title: Text('Support'),
            ),
            ListTile(
              onTap: (() {
                Navigator.pushNamedAndRemoveUntil(
                    context, AboutUs.idScreen, (route) => false);
              }),
              leading: const Icon(Icons.info),
              title: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
