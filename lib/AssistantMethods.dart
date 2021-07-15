import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:time_constraint/RequestAssistant.dart';

class AssistantMethods {

  static String key = "AIzaSyCX5sutODXIcV4NT5gQwHOkYAjW-ZRbweo";

  static Future<String> getLocationName(LatLng position) async {

    String addr = "";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$key";

    var response = await RequestAssistant.getRequest(url);

    if (response != "Failed" && response["status"] == "OK") {
      addr = response["results"][0]["formatted_address"];
    }

    return addr;

  }

  static Future<List<PointLatLng>> getRoute(LatLng curr, LatLng dest) async {

    PolylinePoints polylinePoints = PolylinePoints();
    PointLatLng origin = PointLatLng(curr.latitude, curr.longitude);
    PointLatLng destination = PointLatLng(dest.latitude, dest.longitude);
    PolylineResult result  = await polylinePoints.getRouteBetweenCoordinates(key, origin, destination);
    return result.points;

  }
}