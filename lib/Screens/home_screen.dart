import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider_app/Assistants/assistant%20_methods.dart';
import 'package:rider_app/Authentication/login_screen.dart';
import 'package:rider_app/allWidgets/divider_widget.dart';
import 'package:rider_app/allWidgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  //create a route
  static String idScreen = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  //geolocator:
  Position? currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng livePosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: livePosition, zoom: 14);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

//to get the address the user inputs into the app:
    String address = await AssistantMethods.searchCoordinateAddress(position);
    print("this is your address" + address);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double bottomPaddingOfMap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Bolt!',
            style: GoogleFonts.getFont('Lato'),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                onPressed: (() {
                  _firebaseAuth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                }),
                icon: const Icon(Icons.logout))
          ],
        ),
        //create a drawer
        drawer: const DrawerWidget(),
        //body of the app
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                //call the locate posion function
                locatePosition();
                setState(() {
                  bottomPaddingOfMap = 280.0;
                });
              },
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 280,
                width: 200,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6.0,
                      ),
                      const Center(
                        child: Text(
                          "Hi there, ",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Where to? ",
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: "Brand-Bold"),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search,
                                color: Colors.pinkAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Search Drop off"),
                            ],
                          ),
                        ),
                      ),
                      //Home address row
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Add Home"),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Your living home address,",
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      const DividerWidget(),
                      // office address row
                      const SizedBox(
                        height: 14.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.work,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Add Work"),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Your office address,",
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
