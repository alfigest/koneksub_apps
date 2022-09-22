import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:waste_application/drop/viewmodel/droppoint_viewmodel.dart';

import '../theme.dart';

class DropPointPage extends StatefulWidget {
  const DropPointPage({Key? key}) : super(key: key);

  @override
  State<DropPointPage> createState() => _DropPointPageState2();
}

class _DropPointPageState2 extends State<DropPointPage> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  Position? position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  List<double> totalDistance = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkGps();
    Provider.of<PartnerShipListViewModel>(context, listen: false).getAll();
  }

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        margin: EdgeInsets.only(top: 25, bottom: 25, left: 25),
        child: Column(
          children: [
            //Icon(Icons.arrow_back),
            Text(
              'Drop Point Area',
              style: primaryTextStyle.copyWith(
                fontSize: 23,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      );
    }

    final vm = Provider.of<PartnerShipListViewModel>(context);
    print(position == null);
    getDistance(vm, 4);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Icon(
                Icons.arrow_back,
                size: 30,
              ),
              SizedBox(
                width: 30,
              ),
              _header(),
            ],
          ),

          for (int i = 0; i < 4; i++)
            totalDistance.isNotEmpty
                ? RoundBox(
                    options: vm.partners[i],
                    distance: totalDistance[i].toStringAsFixed(2))
                : Center(
                    child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: Colors.black, size: 25),
                  ),

          //Expanded(child: PartnerList(options: vm.partners)),
          // Text(
          //   "Start  :\nLAT: $lat, LNG: $long",
          // ),
          // Text(
          //   "End    :\nLAT: ${vm.partners[0].coord?.latitude}, LNG: ${vm.partners[0].coord?.longitude}",
          // ),
          //Text("Total Distance : ${totalDistance} KM")
        ],
      ),
    );
  }

  Future getDistance(PartnerShipListViewModel vmtest, int limit) async {
    if (position != null && vmtest.partners.isNotEmpty) {
      totalDistance.clear();
      for (var i = 0; i < limit; i++) {
        totalDistance.add(Geolocator.distanceBetween(
                position!.latitude,
                position!.longitude,
                vmtest.partners[i].coord!.latitude,
                vmtest.partners[i].coord!.longitude) /
            1000);
      }
    } else {
      return;
    }
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position.longitude); //Output: 80.24599079
    // print(position.latitude); //Output: 29.6593457

    long = position!.longitude.toString();
    lat = position!.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      // print(position.longitude); //Output: 80.24599079
      // print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }
}

class RoundBox extends StatelessWidget {
  const RoundBox({required this.options, required this.distance, Key? key})
      : super(key: key);
  final PartnerShipViewModel options;
  final String? distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/1.JPG'),
                alignment: Alignment.centerLeft,
                //fit: BoxFit.fill,
              ),
              color: Colors.white60,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: EdgeInsets.only(left: 120, top: 8, right: 15, bottom: 20),
            margin: EdgeInsets.only(left: 5, bottom: 10, top: 10, right: 5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //DISPLAY PARTNER NAME
                      Container(
                        //padding: EdgeInsets.only(top: 0, right: 10.0),
                        child: Text(options.name!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                      ),
                      // Expanded(
                      //     child: Container(
                      //   width: 50,
                      //   color: Colors.red,
                      // )),
                      //DISPLAY STATUS OF THE PARTNER
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Status : ' + options.status!,
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0)),
                      ),
                      //DISPLAY ADDRESS OF THE PARTNER
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          options.address!,
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, left: 20, bottom: 5.0, right: 5),
                      child: Text('$distance',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20),
                      child: Text('KM',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0)),
                    ),
                  ],
                ),
              ],
            )));
  }
}

// class DropPointPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Widget _header() {
//       return Container(
//         margin: EdgeInsets.only(top: 50, bottom: 25, left: 25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Drop Point Area',
//               style: primaryTextStyle.copyWith(
//                 fontSize: 23,
//                 fontWeight: semiBold,
//               ),
//             )
//           ],
//         ),
//       );
//     }

//     // Widget _banner() {
//     //   return;
//     // }

//     return Scaffold(
//       body: ListView(
//         children: [
//           _header(),
//           RoundBox('assets/images/1.JPG', 'Drop point 1', '',
//               'Jl. Karah Agung Blok H-18 ', '200 M'),
//           RoundBox(
//               'assets/images/3.JPG', 'Drop Point 2', '', 'Jl. Arief ', '750 M'),
//           RoundBox(
//               'assets/images/2.JPG', 'Drop Point 3', '', 'Jl. Arief ', '1 KM'),
//           RoundBox(
//               'assets/images/1.JPG', 'Drop Point 4', '', 'Jl. Arief ', '2 KM'),
//           RoundBox('assets/images/3.JPG', 'Drop Point 5', '', 'Jl. Arief ',
//               '2.3 KM'),
//           RoundBox(
//               'assets/images/2.JPG', 'Drop Point 6', '', 'Jl. Arief ', '2.5 KM')
//         ],
//       ),
//     );
//   }
// }