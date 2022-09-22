import 'package:cloud_firestore/cloud_firestore.dart';

import '../reward_transactions.dart';

class RewardTransactionService {
  static final CollectionReference _collection =
      FirebaseFirestore.instance.collection('reward_transactions');

  static Future<List<RewardTransaction>> getAll() async {
    final QuerySnapshot snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      return RewardTransaction.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  static Future<RewardTransaction> get(String id) async {
    final DocumentSnapshot snapshot = await _collection.doc(id).get();
    return RewardTransaction.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  static Future<void> add(RewardTransaction option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.set(option.toJson());
  }

  static Future<void> update(RewardTransaction option) async {
    DocumentReference doc = _collection.doc(option.id);
    await doc.update(option.toJson());
  }

  static Future<void> delete(String id) async {
    DocumentReference doc = _collection.doc(id);
    await doc.delete();
  }
}
