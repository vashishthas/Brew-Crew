import 'package:brew_crew/models/user1.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey=GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];

  //formValues
  String _currentName;
  String _currentSugars;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {

    User1 user= Provider.of<User1>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData=snapshot.data;
          return SingleChildScrollView(
                      child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val)=> val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val)=> setState(() => _currentName=val),
                  ),
                  SizedBox(height: 20.0),
                  //dropDown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars ,
                    items: sugars.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e sugars')
                        );
                    }).toList(),
                    onChanged: (val)=> setState(() => _currentSugars=val),
                    ),
                  //slider
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(), 
                    onChanged: (val)=> setState(() => _currentStrength=val.round())
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid)
                        .updateUserData(
                          _currentSugars ?? userData.sugars, 
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                          );
                        Navigator.pop(context);
                      }
                      // print(_currentName);
                      // print(_currentSugars);
                      // print(_currentStrength);
                    }
                  ),
                ]
              ),
            ),
          );
        }
        else{
          return Loading();
        }
        
      }
    );
  }
}