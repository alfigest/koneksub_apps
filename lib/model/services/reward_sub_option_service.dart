import 'package:cloud_firestore/cloud_firestore.dart';

import '../reward_sub_option.dart';

class RewardSubOptionService {
  final String documentId;
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('reward_options');
  RewardSubOptionService({required this.documentId}) {
    _collection = _collection.doc(documentId).collection('sub_options');
  }

  Future<List<RewardSubOption>> getAll() async {
    final QuerySnapshot snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      return RewardSubOption.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<RewardSubOption> get(String id) async {
    final DocumentSnapshot snapshot = await _collection.doc(id).get();
    return RewardSubOption.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> add(RewardSubOption option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.set(option.toJson());
  }

  Future<void> update(RewardSubOption option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.update(option.toJson());
  }

  Future<void> delete(String id) async {
    DocumentReference doc = _collection.doc(id);
    await doc.delete();
  }
}
