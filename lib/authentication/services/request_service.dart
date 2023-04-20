import 'package:aktientool/filter/searcharea.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestService {
  CollectionReference request =
      FirebaseFirestore.instance.collection('requests');
  final id = FirebaseAuth.instance.currentUser!.email;

  Stream<int> getrequests() {
    return request.doc(id).snapshots().map(fromSnapshot);
  }

  Future<int> getrequestsfuture() {
    return request.doc(id).get().then(fromSnapshot);
  }

  Future addRequests(int amount) async {
    return request
        .doc(id)
        .update({'request': (await getrequestsfuture() + amount)});
  }

  Future updateRequests() {
    return request.doc(id).update({'request': (requestsLeft - 1)});
  }

  static int fromSnapshot(DocumentSnapshot doc) =>
      (doc.data() as Map).containsKey("request") ? doc.get("request") : 0;
}
