
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
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

  int modeCounter = 0;
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



class DisplayMap extends StatefulWidget {

  final bool currLocationPage;

  DisplayMap({required tapOnCurrentLocation}) :
      currLocationPage = tapOnCurrentLocation;




  @override
  State<DisplayMap> createState() => MapState();


}

class MapState extends State<DisplayMap> {

  Completer<GoogleMapController> _controller = Completer();
  late Map<String, Marker?> markers;
  late final PageController locationDisplayController;
  late LatLng curr;
  late LatLng dest;
  
  @override
  void initState() {
    curr = dest = LatLng(0,0);
    locationDisplayController = PageController(initialPage: widget.currLocationPage ? 0 : 1);
    markers = {
      "current" : null,
      "destination" : null
    };
    super.initState();
  }


  Set<Marker> toSet(Map<String, Marker?> marker) {
    Set<Marker> res = Set();

    if (marker["current"] != null) {
      res.add(marker["current"]!);
    }

    if (marker["destination"] != null) {
      res.add(marker["destination"]!);
    }
    return res;
  }

  Future<LatLng> initCurrentLocation() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("location permissions are denied");
      }
    }

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var long = position.longitude;

    return LatLng(lat, long);
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
          children: [
              GoogleMap(
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(13.7650836, 100.5379664),
                  zoom: 16,
                ),
                markers: toSet(markers),
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
                      markers["destination"] = marker;
                      dest = tappedPos;
                    } else {
                      markers["current"] = marker;
                      curr = tappedPos;
                    }
                  });

                },
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
                return Text("-",
                    style: TextStyle(
                        fontSize: width * 0.035
                    )
                );
              }
            }
        ),
        ElevatedButton(
          onPressed: () async {
            if (markers["current"] != null) {
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
              return Text("-",
                  style: TextStyle(
                      fontSize: width * 0.035
                  )
              );
            }
          }
        ),
        ElevatedButton(
          onPressed: () async {
            if (markers["current"] == null) {
              locationDisplayController.animateToPage(0,
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

}

