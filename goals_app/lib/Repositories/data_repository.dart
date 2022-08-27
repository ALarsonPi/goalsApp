import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goals_app/Objects/Priority.dart';

import '../global.dart';

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('user/1/prioritires');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPriority(Priority currPriority) {
    return collection.add(currPriority.toJson());
  }

  static void getPriorities() async {
    // collection.snapshots().listen((data) {
    //   var allPriorities = data.docs[0]['priorities'];
    //   int index = 0;
    //   for (var currPriority in allPriorities) {
    //     Priority newPriority = Priority.fromJson(currPriority);
    //     Global.userPriorities.add(newPriority);
    //     index++;
    //   }
    // });
  }

  void updatePriority(Priority currPriority) async {
    await collection.doc(currPriority.name).update(currPriority.toJson());
  }

  void deletePriority(Priority currPriority) async {
    await collection.doc(currPriority.name).delete();
  }
}
