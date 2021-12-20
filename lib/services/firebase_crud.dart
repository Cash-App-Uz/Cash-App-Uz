import 'package:cash_app/constants/imports.dart';

//Diyorbek
class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getDocuments(String docPath,
      [String? category]) async {
    List<Map<String, dynamic>> data = [];
    try {
      QuerySnapshot<Object?> querySnapshot = category != null
          ? await _db
              .collection(docPath)
              .where("type", isEqualTo: category)
              .orderBy("time", descending: true)
              .get()
          : await _db
              .collection(docPath)
              .orderBy("time", descending: true)
              .get();
      for (QueryDocumentSnapshot<Object?> doc in querySnapshot.docs) {
        data.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      e;
    }

    return data;
  }

  Stream<QuerySnapshot> streamDataCollection(String collectionPath) async* {
    yield* _db.collection(collectionPath).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(
      String id, String collectionPath) async {
    return await _db.collection(collectionPath).doc(id).get();
  }

  Future<void> removeDocument(String id, String collectionPath) async {
    await _db.collection(collectionPath).doc(id).delete();
  }

  Future<DocumentReference> addDocument(
      Map<String, dynamic> data, String collectionPath) {
    return _db.collection(collectionPath).add(data);
  }

  Future<void> updateDocument(
      Map<String, dynamic> data, String id, String collectionPath) async {
    return _db.collection(collectionPath).doc(id).update(data);
  }
}
