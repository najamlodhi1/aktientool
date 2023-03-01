import 'package:aktientool/filter/searcharea.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestService {
  CollectionReference request =
      FirebaseFirestore.instance.collection('requests');
  final id = FirebaseAuth.instance.currentUser!.uid;

  Stream<int> getrequests() {
    return request.doc(id).snapshots().map(fromSnapshot);
  }

  Future updateRequests() {
    return request.doc(id).update({'req': (requestsLeft - 1)});
  }

  static int fromSnapshot(DocumentSnapshot doc) => doc.get("req");
}
