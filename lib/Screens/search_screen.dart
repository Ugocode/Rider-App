import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/DataHandler/app_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //addding the place address
    String placeAdrress =
        Provider.of<AppData>(context).pickUpLocation?.placeName ?? " ";
    pickUpTextEditingController.text = placeAdrress;
    return Scaffold(
      body: Column(children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.6,
                offset: Offset(0.7, 0.7),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 25, right: 25, bottom: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    GestureDetector(
                        onTap: (() {
                          Navigator.pop(context);
                        }),
                        child: const Icon(Icons.arrow_back_ios_new)),
                    const Center(
                      child: Text(
                        'Set Drop off',
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: 'Brand-bold'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Image.asset(
                      'Assets/images/carAndroid.png',
                      height: 20.0,
                      width: 20.0,
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                          controller: pickUpTextEditingController,
                          decoration: InputDecoration(
                              hintText: "PickUp Location",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 11, top: 8, bottom: 8)),
                        ),
                      ),
                    ))
                  ],
                ),
                //second row:::::::::::::::::::::
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Image.asset(
                      'Assets/images/carios.png',
                      height: 20.0,
                      width: 20.0,
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                          controller: dropOffTextEditingController,
                          decoration: InputDecoration(
                              hintText: "Where to?",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 11, top: 8, bottom: 8)),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
