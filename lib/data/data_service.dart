import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataService {
  final db = FirebaseFirestore.instance;

  Future<String?> store({
    required String collection,
    required String queue,
    required String rm,
    required String bpjs,
    required String nik,
    required String nama,
    required String ttl,
    required String alamat,
    required String tujuan,
    required String keluhan,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      int newQueue = (int.parse(queue) + 1);
      db.collection(collection).doc(uid).set({
        'queue': newQueue.toString(),
        'rm': rm,
        'bpjs': bpjs,
        'nik': nik,
        'nama': nama,
        'ttl': ttl,
        'alamat': alamat,
        'tujuan': tujuan,
        'keluhan': keluhan
      }).onError((error, stackTrace) => print("Error writing : $error"));

      // var test = 0;
      // db.collection(collection).get().then(
      //   (querySnapshot) {
      //     print("Successfully completed");
      //     for (var docSnapshot in querySnapshot.docs) {
      //       print('${docSnapshot.id} => ${docSnapshot.data()}');
      //     }
      //   },
      //   onError: (e) => print("Error completing: $e"),
      // );
      // print('ini test : ${test}');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
