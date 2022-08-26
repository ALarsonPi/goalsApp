import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goals_app/Objects/Priority.dart';

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('priorities');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPet(Priority currPriority) {
    return collection.add(currPriority.toJson());
  }

  void updatePet(Priority currPriority) async {
    await collection.doc(currPriority.name).update(currPriority.toJson());
  }

  void deletePet(Priority currPriority) async {
    await collection.doc(currPriority.name).delete();
  }
}
