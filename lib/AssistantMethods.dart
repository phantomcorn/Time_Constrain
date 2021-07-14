import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:time_constraint/RequestAssistant.dart';

class AssistantMethods {

  static Future<String> getLocationName(LatLng position) async {

    String addr = "";
    String key = "AIzaSyCX5sutODXIcV4NT5gQwHOkYAjW-ZRbweo";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$key";

    var response = await RequestAssistant.getRequest(url);

    if (response != "Failed" && response["status"] == "OK") {
      addr = response["results"][0]["formatted_address"];
    }

    return addr;

  }
}