import 'package:brew_crew/models/user1.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  //create userObject based on FirebaseUser
  
  User1 _userFromFirebaseUser(User user){ //By tis we only tale the uid from user object
    return user!=null ? User1(uid:user.uid):null;
  }

  //auth change user stream
  Stream <User1> get user{
    return _auth.authStateChanges()
    //.map((User user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }

  //sign in anon
  
  Future signInAnon() async{
    try{
      UserCredential result= await _auth.signInAnonymously();
      User user= result.user;
      return _userFromFirebaseUser(user);
      }
    catch(e){
      print(e.toString());
      return null;
    }
  }
 
  //sign in with e&p
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user=result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
 
  //register with e&p
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user=result.user;

      await DatabaseService(uid: user.uid).updateUserData('1', 'newUser', 100);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
 
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}