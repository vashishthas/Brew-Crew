import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{

  final AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[600],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async{
               // print('sign out');
               await _authService.signOut();
              },
            )
          ],
          ),
        ),
    );
  }
}