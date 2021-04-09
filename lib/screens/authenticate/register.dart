import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _authService=AuthService();
  final _formKey=GlobalKey<FormState>();

  String email="";
  String password="";
  String error="";
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('REGISTER!!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.switch_account),
            onPressed: (){
              print('Move To Sign in!!');
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0
          ),
          child:Form(
            key: _formKey ,
            child:Column(children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? "Enter an email": null,
                onChanged: (val){
                  setState(() => email=val);
                }
              ),
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length<6 ? "Enter a password of 6+ characters ": null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password=val);
                }
              ),
              SizedBox(height:20.0),
              ElevatedButton(
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){ //if null then valid
                    setState(() {
                      loading=true;
                    });
                    dynamic result=await _authService.registerWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        error="Please supply a valid email";
                        loading=false; //if wrong user
                      }); 
                    }
                    //print(email);
                    //print(password);
                  }
                },
                ),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style:TextStyle(
                    color: Colors.red,
                    fontSize: 14.0
                    )
                  ),

            ],
            ),
            )
          ,
      ),
    );
  }
}