
import 'dart:async';

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

  TextEditingController currController = TextEditingController(text: "Current Location");
  TextEditingController destController = TextEditingController(text: "Destination");
  LatLng? curr;
  LatLng? dest;

  void setLocationName(TextEditingController controller, String value) {
    setState(() {
      controller.text = value;
    });
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
                                child :TextButton(
                                  onPressed: () async {
                                    curr = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            Map(
                                                positionCallBack: setLocationName,
                                                locationController: currController,
                                                initialPos: curr,
                                            )
                                        )
                                    );
                                  },
                                  child: Text(currController.text,
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
                                    onPressed: () async {
                                      dest = await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              Map(
                                                positionCallBack: setLocationName,
                                                locationController: destController,
                                                initialPos: dest,
                                              )
                                          )
                                      );
                                    },
                                    child: Text(destController.text,
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
                      ElevatedButton(
                          onPressed: () {
                            print(curr);
                            print(dest);
                          },
                          child: Text("GO!",
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  color: Colors.black
                              )
                          )
                      )
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



class Map extends StatefulWidget {

  final Function(TextEditingController, String) callback;
  final TextEditingController locationController;
  final LatLng? initialPosition;

  Map({required positionCallBack, required locationController, LatLng? initialPos}) :
      this.locationController = locationController,
      this.callback = positionCallBack,
      initialPosition = initialPos;



  @override
  State<Map> createState() => MapState();


}

class MapState extends State<Map> {

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  @override
  void initState() {
    if (widget.initialPosition != null) {
      markers.add(
          Marker(
            markerId: MarkerId(widget.initialPosition!.toString()),
            position: widget.initialPosition!
          )
      );

    }
    super.initState();
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
                  target: widget.initialPosition ?? LatLng(13.7650836, 100.5379664),
                  zoom: 16,
                ),
                markers: Set.from(markers),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: (LatLng tappedPos) async {

                  markers = [];
                  Marker marker = Marker(
                      markerId: MarkerId(tappedPos.toString()),
                      position: tappedPos
                  );
                  String locationName = await AssistantMethods.getLocationName(marker.position);

                  setState(() {
                    markers.add(marker);
                    widget.callback(widget.locationController, locationName);
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
                    child: Column(
                      children: [
                        Text("Pick your current location",
                            style: TextStyle(
                                fontSize: width * 0.035
                            )
                        ),
                        Text(widget.locationController.text,
                            style: TextStyle(
                                fontSize: width * 0.035
                            )
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            //second arg returns a result
                            if (markers.isNotEmpty) {
                              Navigator.pop(context, markers[0].position);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Done",
                            style: TextStyle(
                              fontSize: width * 0.04,
                            ),
                          ),
                        )
                      ],
                    )
                  )
              )
         ],
       )
    );
  }

}

