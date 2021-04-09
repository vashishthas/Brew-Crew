import 'package:brew_crew/models/user1.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: Return either Home or Authenticate
    
    final user=Provider.of<User1>(context);
    print(user);

    if(user==null)
    return Authenticate();
    else
    return Home();
  }

}