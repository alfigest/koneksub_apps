import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/droppointmodel.dart';
import '../model/service/droppointservice.dart';

class PartnerShipViewModel {
  final PartnerShip partnerShip;

  PartnerShipViewModel(this.partnerShip);

  String? get id => partnerShip.id;
  GeoPoint? get coord => partnerShip.coord;
  String? get name => partnerShip.name;
  String? get address => partnerShip.address;
  String? get status => partnerShip.status;
  String? get email => partnerShip.email;
  String? get whatsapp => partnerShip.whatsapp;
}

class PartnerShipListViewModel extends ChangeNotifier {
  List<PartnerShipViewModel> partners = <PartnerShipViewModel>[];
  // String documentId;
  // PartnerShipListViewModel(this.documentId) {
  //   partners = <PartnerShipViewModel>[];
  // }
  Future<void> getAll() async {
    partners = await PartnerShipService.getall().then((partnerShip) {
      return partnerShip.map((partnerShip) {
        return PartnerShipViewModel(partnerShip);
      }).toList();
    });
    notifyListeners();
  }
}
