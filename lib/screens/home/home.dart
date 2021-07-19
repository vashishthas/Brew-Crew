import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget{

  final AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
        showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0
                ),
                child: SettingsForm(),
            );
          });
    }

    return Container(
      // ignore: missing_required_param
      child: StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
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
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: (){
                  _showSettingsPanel();
                })
            ],
            ),
            body: Container(
              child: BrewList(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/coffee_bg.png'),
                  fit: BoxFit.cover,
                  )
                ),
              ),
          ),
      ),
    );
  }
}