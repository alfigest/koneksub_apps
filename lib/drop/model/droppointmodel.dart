import 'package:cloud_firestore/cloud_firestore.dart';

class PartnerShip {
  final String? id;
  final GeoPoint? coord;
  final String? address;
  final String? name;
  final String? email;
  final String? whatsapp;
  final String? status;

  PartnerShip({
    this.id,
    this.coord,
    this.address,
    this.name,
    this.email,
    this.whatsapp,
    this.status,
  });

  factory PartnerShip.fromJson(Map<String, dynamic> json) => PartnerShip(
        id: json['id'],
        coord: json["coord"],
        address: json["drop_point"],
        name: json["nama_mitra"],
        email: json["email_mitra"],
        whatsapp: json["whatsapp"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "coord": coord,
        "drop_point": address,
        "nama_mitra": name,
        "email_mitra": email,
        "whatsapp": whatsapp,
        "status": status,
      };
}
