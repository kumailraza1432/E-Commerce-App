import 'package:flutter/cupertino.dart';
import 'package:fproject/Screens/login.dart';
import 'package:fproject/Screens/register.dart';

class authentication extends StatefulWidget {
  const authentication({Key? key}) : super(key: key);

  @override
  State<authentication> createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn =! showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return LoginScreen(toggleView: toggleView);
    }
    else{
      return RegisterScreen(toggleView: toggleView);
    }
  }
}
