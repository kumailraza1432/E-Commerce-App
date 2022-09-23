import 'package:flutter/cupertino.dart';
import 'package:fproject/Screens/afterAuthentication/home/home.dart';
import 'package:fproject/Screens/authenticate.dart';
import 'package:fproject/Screens/login.dart';
import 'package:fproject/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final userr = Provider.of<personalUser?>(context);
    if(userr!=null){
      print('user here');
      return HomeScreen();
    }
    else{
      print("no user");
      return authentication();
    }
  }
}
