import 'package:geolocator/geolocator.dart';
import 'package:rider_app/Assistants/requests_assistants.dart';
import 'package:rider_app/Keys/config_maps.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(Position position) async {
    // create a placeholder for our address
    String placeAddress = "";

    //get the url to give us the long and lat:
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if (response != "failed") {
      //collect the address
      placeAddress = response["results"][0]["formatted_address"];
    }
//return the address:
    return placeAddress;
  }
}
