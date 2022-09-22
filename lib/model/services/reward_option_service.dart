import 'package:cloud_firestore/cloud_firestore.dart';

import '../reward_option.dart';

class RewardOptionService {
  static final CollectionReference _collection =
      FirebaseFirestore.instance.collection('reward_options');

  static Future<List<RewardOption>> getAll() async {
    final QuerySnapshot snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      return RewardOption.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  static Future<RewardOption> get(String id) async {
    final DocumentSnapshot snapshot = await _collection.doc(id).get();
    return RewardOption.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  static Future<void> add(RewardOption option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.set(option.toJson());
  }

  static Future<void> update(RewardOption option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.update(option.toJson());
  }

  static Future<void> delete(String id) async {
    DocumentReference doc = _collection.doc(id);
    await doc.delete();
  }
}
