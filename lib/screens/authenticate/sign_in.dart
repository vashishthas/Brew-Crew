import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading =false;

  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.switch_account),
            onPressed: (){
              print('Move To Register!!');
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
            key: _formKey,
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
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){  
                    setState(() {
                      loading=true;
                    });
                    print('Valid!!');                   
                    dynamic result= await _authService.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                      error="Could not sign in with those credentials!!";
                      loading=false;
                    }); 
                    }
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