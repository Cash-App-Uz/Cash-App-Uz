import 'package:cash_app/constants/imports.dart';
//Diyorbek
class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late CollectionReference ref;
  final String path;
  Api(this.path) {
    ref = _db.collection(path);
  }
  Future<QuerySnapshot> getDataCollection() async {
    return ref.get();
  }

  Future<List<IoModel>> getDocuments() async {
    List<IoModel> ioData = [];

    QuerySnapshot<Object?> a = await ref
        .where(
          "category",
          isEqualTo: "express",
        )
        .get();
    try {
      for (QueryDocumentSnapshot<Object?> io in a.docs) {
        ioData.add(IoModel.fromJson(io.data() as Map<String, dynamic>));
      }
    } catch (e) {
      e.toString();
    }

    QuerySnapshot data = await ref.get();
    try {
      for (QueryDocumentSnapshot<Object?> io in data.docs) {
        ioData.add(IoModel.fromJson(io.data() as Map<String, dynamic>));
      }
    } catch (e) {
      e.toString();
    }

    return ioData;
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

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map<String, dynamic> data, String id) async {
    return ref.doc(id).update(data);
  }
}
