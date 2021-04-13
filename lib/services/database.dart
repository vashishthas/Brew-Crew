import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user1.dart';
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


  //Brew List from snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? "",
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
      ); 
    }).toList();
  }

  //User data from snapshot
  
  UserData _userDataFromDocumentSnapshot(DocumentSnapshot snapshot){
    print(snapshot.id);
    return UserData(
      uid: uid, 
      name: snapshot.data()['name'], 
      sugars: snapshot.data()['sugars'], 
      strength:snapshot.data()['strength']
       );
  }

  //Get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromDocumentSnapshot);
  }
}