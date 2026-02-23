import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/core/service/firestore_model.dart';

import 'firestore_type_service.dart';

class FirebaseStoreService<T extends FirestoreModel>
    implements FirestoreTypeService<T> {
  final FirebaseFirestore _firestore;
  final String collectionPath;
  final T Function(Map<String, dynamic> map)
  fromMap; //take data form firestore and convert it to model

  FirebaseStoreService({
    required FirebaseFirestore firestore,
    required this.collectionPath,
    required this.fromMap,
  }) : _firestore = firestore;

  FirebaseFirestore get firestore => _firestore;

  @override
  Future<void> add(T model) {
    return _firestore
        .collection(collectionPath)
        .doc(model.id)
        .set(model.toMap());
  }

  @override
  Future<void> delete(String id) {
    return _firestore.collection(collectionPath).doc(id).delete();
  }

  @override
  Future<List<T?>> getAll() {
    return _firestore
        .collection(collectionPath)
        .get()
        .then((doc) => doc.docs.map((e) => fromMap(e.data())).toList());
  }

  @override
  Future<T?> getOne(String id) {
    return _firestore.collection(collectionPath).doc(id).get().then((doc) {
      if (doc.exists) {
        return fromMap(doc.data()!);
      } else {
        return null;
      }
    });
  }

  Future<List<T?>> getManyByCategory(String value, {int limit = 4}) {
    return _firestore
        .collection(collectionPath)
        .where('category', isEqualTo: value)
        .limit(limit)
        .get()
        .then((doc) => doc.docs.map((e) => fromMap(e.data())).toList());
  }

  @override
  Future<void> update(T model) {
    return _firestore
        .collection(collectionPath)
        .doc(model.id)
        .update(model.toMap());
  }
}
