// ignore: file_names
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/Assistants/requests_assistants.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/Keys/config_maps.dart';
import 'package:rider_app/Models/address.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    // create a placeholder for our address from the API
    String placeAddress = "";
    String st1, st2, st3, st4;

    //get the url to give us the long and lat:
    String myUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}key=$mapKey";

    var response = await RequestAssistant.getRequest(myUrl);

    if (response.toString() != "failed") {
      //collect the address
      // placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][0]
          ["long_name"]; //house number
      st2 = response["results"][0]["address_components"][1]
          ["long_name"]; //street name
      st3 = response["results"][0]["address_components"][5]
          ["long_name"]; // district name
      st4 = response["results"][0]["address_components"][6]
          ["long_name"]; //state name

      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      Address userPickUpAddress = Address();

      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickupLocationAddress(userPickUpAddress);
    }
//return the address:
    return placeAddress;
  }
}
