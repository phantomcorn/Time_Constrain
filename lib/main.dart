
import "package:latlong2/latlong.dart";
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

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
      home: MyHomePage(title: 'Time Constraint'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget main() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child : Scaffold (
            body: Center(
                child: Container(
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top : height / 6 , bottom : width / 8),
                        child: Text("Where to go?",
                            style: TextStyle(
                                fontSize: width * 0.06,
                                color: Colors.black
                            )
                        ),
                      ),
                      Container(
                          width: width / 1.5,
                          child: Align(alignment: Alignment.center,
                              child: Text("Current location",
                                  style: TextStyle(
                                      fontSize: width * 0.05,
                                      color: Colors.black
                                  )
                              )
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                  color: Colors.blueAccent
                              )
                          )
                      ),
                      Icon(
                        Icons.arrow_downward,
                        size: width * 0.5,
                      ),
                      Container(
                          width: width / 1.5,
                          child: Align(alignment: Alignment.center,
                              child: Text("Destination",
                                  style: TextStyle(
                                      fontSize: width * 0.05,
                                      color: Colors.black
                                  )
                              )
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(
                                  color: Colors.blueAccent
                              )
                          )
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Map();
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

  /*
  Widget mode() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: ,
          )
        )
    );
  }
   */

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child : Scaffold (
            body: Center(
                child: Container(
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top : height / 10 , bottom : width / 10),
                        child: Text("Where to go?",
                            style: TextStyle(
                                fontSize: width * 0.06,
                                color: Colors.black
                            )
                        ),
                      ),
                      Container(
                          width: width / 1.5,
                          height: height / 9,
                          child: Align(alignment: Alignment.center,
                              child: Text("Current location",
                                  style: TextStyle(
                                      fontSize: width * 0.05,
                                      color: Colors.black
                                  )
                              )
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                  color: Colors.blueAccent
                              )
                          )
                      ),
                      Container(
                        width: width / 1.5,
                        height:  height / 3,
                        child: Stack(
                          children: [
                            Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black
                                  )
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: width * 0.6
                                )
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              child: ModeButton(
                                width: width,
                                height: height
                              ),
                              decoration: BoxDecoration(
                               border: Border.all(
                                 color: Colors.black
                               )
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: height / 9,
                          width: width / 1.5,
                          child: Align(alignment: Alignment.center,
                              child: Text("Destination",
                                  style: TextStyle(
                                      fontSize: width * 0.05,
                                      color: Colors.black
                                  )
                              )
                          ),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              border: Border.all(
                                  color: Colors.blueAccent
                              )
                          )
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Map();
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

  @override
  State<Map> createState() => _MapState();

}

class _MapState extends State<Map> {

  late MapController controller;

  @override
  void initState() {
    controller = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) =>
                Container(
                  child: FlutterLogo(),
                ),
            ),
          ],
        )
      ]
    );
  }

}
