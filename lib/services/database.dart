import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid}); 

  //collecyion Reference
  final CollectionReference brewCollection=FirebaseFirestore
  .instance.collection('brews');

  Future updateUserData(String sugars,String name, int strength) async{
    return await brewCollection.doc(uid).set(
      {
        'sugars':sugars,
        'name': name,
        'strength': strength,
      }
    );
  }

  //Get brews stream
  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}