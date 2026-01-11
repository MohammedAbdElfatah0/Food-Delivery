import 'firestore_model.dart';

abstract class FirestoreTypeService<T extends FirestoreModel> {
  //crete
  Future<void> add(T model);
  //get
  Future<T?> getOne(String id);
  Future<List<T?>> getAll();
  //update
  Future<void> update(T model);
  //delete
  Future<void> delete(String id);
}
