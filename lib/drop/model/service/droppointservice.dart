import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../droppointmodel.dart';
import 'package:geolocator/geolocator.dart';

class PartnerShipService {
  static final CollectionReference _collection =
      FirebaseFirestore.instance.collection('mitra');

  static Future<List<PartnerShip>> getall() async {
    final QuerySnapshot snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      return PartnerShip.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  static Future<PartnerShip> get(String id) async {
    final DocumentSnapshot snapshot = await _collection.doc(id).get();
    return PartnerShip.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  static Future<void> add(PartnerShip option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.set(option.toJson());
  }

  static Future<void> update(PartnerShip option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.update(option.toJson());
  }

  static Future<void> delete(String id) async {
    DocumentReference doc = _collection.doc(id);
    await doc.delete();
  }
}

// class UserService {
//   bool servicestatus = false;
//   bool haspermission = false;
//   late LocationPermission permission;
//   late Position position;
//   String long = "", lat = "";
//   late StreamSubscription<Position> positionStream;

//   checkGps() async {
//     servicestatus = await Geolocator.isLocationServiceEnabled();
//     if (servicestatus) {
//       permission = await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           print('Location permissions are denied');
//         } else if (permission == LocationPermission.deniedForever) {
//           print("'Location permissions are permanently denied");
//         } else {
//           haspermission = true;
//         }
//       } else {
//         haspermission = true;
//       }

//       //   if (haspermission) {
//       //     setState(() {
//       //       //refresh the UI
//       //     });

//       //     getLocation();
//       //   }
//       // } else {
//       //   print("GPS Service is not enabled, turn on GPS location");
//       // }

//       // setState(() {
//       //   //refresh the UI
//       // });
//     }

//     getLocation() async {
//       position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       print(position.longitude); //Output: 80.24599079
//       print(position.latitude); //Output: 29.6593457

//       long = position.longitude.toString();
//       lat = position.latitude.toString();

//       // setState(() {
//       //   //refresh UI
//       // });

//       LocationSettings locationSettings = LocationSettings(
//         accuracy: LocationAccuracy.high, //accuracy of the location data
//         distanceFilter: 100, //minimum distance (measured in meters) a
//         //device must move horizontally before an update event is generated;
//       );

//       StreamSubscription<Position> positionStream =
//           Geolocator.getPositionStream(locationSettings: locationSettings)
//               .listen((Position position) {
//         print(position.longitude); //Output: 80.24599079
//         print(position.latitude); //Output: 29.6593457

//         long = position.longitude.toString();
//         lat = position.latitude.toString();

//         // setState(() {
//         //   //refresh UI on update
//         // });
//       });
//     }
//   }
// }
