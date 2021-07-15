
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:time_constraint/AssistantMethods.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(title: 'Time Constrain'),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {

  DisplayMap? map;

  @override
  void initState() {
    super.initState();
    initLocationService().then((isEnabled) {
      if (!isEnabled) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title : Text("Accept?"),
                  content: Text("This app requires the use of location service. Please update it in your setting in order to user the app "),
                  actions: [
                    CupertinoDialogAction(
                        child: Text("Yes"),
                        onPressed: () {
                          Geolocator.openAppSettings();
                          Navigator.pop(context);
                        }
                    ),
                    CupertinoDialogAction(child: Text("No"),
                        onPressed: () => exit(0)
                    )
                  ],
                );
              }
          );
      }
    });
  }

  Future<bool> initLocationService() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    } else if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child : Scaffold (
            body: Center(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top : height / 10 , bottom : width / 10),
                        child: Text("Where to go?",
                            style: TextStyle(
                                fontSize: width * 0.06,
                                color: Colors.black
                            )
                        )
                      ),
                      Container(
                          width: width / 1.5,
                          height: height / 9,
                          child: Align(alignment: Alignment.center,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child : TextButton(
                                  onPressed: () {
                                    if (map == null) {
                                      map = DisplayMap(tapOnCurrentLocation : true);
                                    }

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                          map!
                                        )
                                    );
                                  },
                                  child: Text("Current location",
                                    style: TextStyle(
                                        fontSize: width * 0.04,
                                        color: Colors.black,
                                    ),
                                  )
                                )
                              )
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                  color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      Container(
                        width: width / 1.5,
                        height:  height / 3,
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: Icon(
                          Icons.arrow_downward,
                          size: width * 0.6
                        )
                      ),
                      Container(
                          height: height / 9,
                          width: width / 1.5,
                          child: Align(alignment: Alignment.center,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child : TextButton(
                                    onPressed: () {
                                      if (map == null) {
                                        map = DisplayMap(tapOnCurrentLocation: false);
                                      }

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              map!
                                          )
                                      );
                                    },
                                    child: Text("Destination",
                                        style: TextStyle(
                                            fontSize: width * 0.04,
                                            color: Colors.black
                                        )
                                    ),
                                )
                              )
                          ),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              border: Border.all(
                                  color: Colors.blueAccent
                              ),
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                )
            )
        )
    );
  }
}


class ModeButton extends StatefulWidget {

  final double width;
  final double height;

  ModeButton({required this.width, required this.height});

  @override
  _ModeButtonState createState() => _ModeButtonState();

}

class _ModeButtonState extends State<ModeButton> {

  static int modeCounter = 0;
  late final List<Widget> mode;
  
  @override
  void initState() {
    mode = [
      normal(),
      comfort(),
      fast(),
      luxury()
    ];
    super.initState();
  }
  
  Widget comfort() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            if (modeCounter == 3) {
              modeCounter = 0;
            } else {
              modeCounter ++;
            }
          });
        },
        child: Text("Comfort mode",
          style: TextStyle(
              fontSize: widget.width * 0.035
          )
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent
        ),
    );
  }

  Widget fast() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (modeCounter == 3) {
            modeCounter = 0;
          } else {
            modeCounter ++;
          }
        });
      },
      child: Text("Fast mode",
          style: TextStyle(
              fontSize: widget.width * 0.035
          )
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.red
      ),
    );
  }

  Widget normal() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (modeCounter == 3) {
            modeCounter = 0;
          } else {
            modeCounter ++;
          }
        });
      },
      child: Text("Normal mode",
          style: TextStyle(
              fontSize: widget.width * 0.035
          )
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.green
      ),
    );
  }

  Widget luxury() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (modeCounter == 3) {
            modeCounter = 0;
          } else {
            modeCounter ++;
          }
        });
      },
      child: Text("Luxury mode",
          style: TextStyle(
              fontSize: widget.width * 0.035
          )
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.yellow
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return mode[modeCounter];
  }

}


enum Location {
  current,
  destination
}

class DisplayMap extends StatefulWidget {

  final bool currLocationPage;

  DisplayMap({required tapOnCurrentLocation}) :
      currLocationPage = tapOnCurrentLocation;


  @override
  State<DisplayMap> createState() => MapState();


}

class MapState extends State<DisplayMap> {

  Completer<GoogleMapController> _controller = Completer();
  late Map<Location, Marker?> markers;
  late final PageController locationDisplayController;
  Set<Polyline> _polylines = {};

  late LatLng curr;
  late LatLng dest;
  
  @override
  void initState() {
    curr = dest = LatLng(0,0);
    locationDisplayController = PageController(initialPage: widget.currLocationPage ? 0 : 1);
    markers = {
      Location.current : null,
      Location.destination : null
    };
    super.initState();
  }


  Set<Marker> markertoSet(Map<Location, Marker?> marker) {
    Set<Marker> res = Set();

    if (marker[Location.current] != null) {
      res.add(marker[Location.current]!);
    }

    if (marker[Location.destination] != null) {
      res.add(marker[Location.destination]!);
    }
    return res;
  }

  Future<LatLng> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var long = position.longitude;
    print(await AssistantMethods.getLocationName(LatLng(lat,long)));
    return LatLng(lat, long);
  }

  void setRoute(List<LatLng> polylineCoordinates) {
    setState(() {
      _polylines = {};
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates
      );

      _polylines.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
          children: [
            FutureBuilder(
              future: getCurrentLocation(),
              builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
                return GoogleMap(
                  zoomGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: snapshot.data ?? LatLng(13.7650836, 100.5379664),
                    zoom: 16,
                  ),
                  markers: markertoSet(markers),
                  polylines: _polylines,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: (LatLng tappedPos) async {

                    Marker marker = Marker(
                        markerId: MarkerId(tappedPos.toString()),
                        position: tappedPos
                    );

                    setState(() {
                      if (locationDisplayController.page!.toInt() == 1) {
                        markers[Location.destination] = marker;
                        dest = tappedPos;
                      } else {
                        markers[Location.current] = marker;
                        curr = tappedPos;
                      }
                    });
                  }
                );
              }
            ),
            Positioned(
                bottom: 0,
                top: height * 0.75,
                child: Container(
                  width: width,
                  height: height / 4,
                  alignment: Alignment.bottomCenter,
                  color: Colors.white,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: locationDisplayController,
                    children: [
                      pickCurr(context),
                      pickDest(context)
                    ],
                  )
                )
            )
         ],
       )
    );
  }

  Widget pickCurr(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text("Pick your current location",
            style: TextStyle(
                fontSize: width * 0.035
            )
        ),
        FutureBuilder(
            future: AssistantMethods.getLocationName(curr),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!,
                    style: TextStyle(
                        fontSize: width * 0.035
                    )
                );
              } else {
                return Text("Could not retrieve data from GoogleMaps",
                    style: TextStyle(
                        fontSize: width * 0.035
                    )
                );
              }
            }
        ),
        ElevatedButton(
          onPressed: () async {
            if (markers[Location.current] != null) {
              locationDisplayController.animateToPage(1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInExpo
              );
            }
          },
          child: Text("Next",
            style: TextStyle(
              fontSize: width * 0.04,
            ),
          ),
        )
      ],
    );
  }

  Widget pickDest(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text("Pick your Destination",
            style: TextStyle(
                fontSize: width * 0.035
            )
        ),
        FutureBuilder(
          future: AssistantMethods.getLocationName(dest),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!,
                  style: TextStyle(
                    fontSize: width * 0.035
                  )
              );
            } else {
              return Text("Could not retrieve data from GoogleMaps",
                  style: TextStyle(
                      fontSize: width * 0.035
                  )
              );
            }
          }
        ),
        ElevatedButton(
          onPressed: () async {
            if (markers[Location.current] == null) {
              locationDisplayController.animateToPage(0,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInExpo
              );
            } else {
              if (markers[Location.destination] != null) {

                var res = await AssistantMethods.getRoute(curr, dest);

                List<LatLng> polylineCoordinates = [];
                if (res.isNotEmpty) {
                  res.forEach((PointLatLng point) {
                    polylineCoordinates.add(
                      LatLng(point.latitude, point.longitude));
                  });
                }

                setRoute(polylineCoordinates);
              }
            }
          },
          child: Text("Next",
            style: TextStyle(
              fontSize: width * 0.04,
            ),
          ),
        )
      ],
    );
  }

}

