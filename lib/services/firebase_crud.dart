import 'package:cash_app/constants/imports.dart';

//Diyorbek
class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference ref;

  Future<QuerySnapshot> getDataCollection() async {
    return ref.get();
  }

  Future<List<Map<String, dynamic>>> getDocuments(String docPath) async {
    List<Map<String, dynamic>>? data;
    try {
      QuerySnapshot<Object?> querySnapshot =
          await _db.collection(docPath).get();
      for (QueryDocumentSnapshot<Object?> doc in querySnapshot.docs) {
        data!.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      e;
    }
    return data!;
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) async {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) async {
    ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map<String, dynamic> data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map<String, dynamic> data, String id) async {
    return ref.doc(id).update(data);
  }
}
