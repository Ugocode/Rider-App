//here we set our provider package

import 'package:flutter/material.dart';
import 'package:rider_app/Models/address.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation;

  void updatePickupLocationAddress(Address pickupAddress) {
    pickUpLocation = pickupAddress;
    notifyListeners();
  }
}
