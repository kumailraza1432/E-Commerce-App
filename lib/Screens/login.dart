import 'package:flutter/material.dart';
import 'package:fproject/Screens/login.dart';
import 'package:fproject/Shared/loader.dart';

import '../Database/firebaseAuth.dart';
import '../Shared/constants.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView ;
  LoginScreen({required this.toggleView});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Authservice _auth = Authservice();
  GlobalKey _formkey = GlobalKey();
  String email='';
  String password='';
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loader() : Scaffold(
      appBar: AppBar(backgroundColor: Colors.black45, elevation: 0,centerTitle: true, title: Text('Firebase App'),
      actions: [
        FlatButton.icon(
          onPressed: (){
            widget.toggleView();
          },
          icon: Icon(Icons.person),
          label: Text('Register'))],),
      body: Container(
          decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('https://th.bing.com/th/id/OIP.8ruUBa7reZ2GraKwDMuq5wHaNK?pid=ImgDet&rs=1'))),
          child: Center(
              child: Form(
                key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 230,),
                      TextFormField(
                        decoration: mydecore.copyWith(hintText: 'Enter your Email'),
                        validator: (val){
                        if(val!.isEmpty){
                        return 'Enter an Email';
                        }
                        else{
                        return null;
                        }
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        }),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: mydecore.copyWith(hintText: 'Enter your Password'),
                          obscureText: true,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Enter an Email';
                            }
                            else{
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          }
                      ),
                      SizedBox(height: 20,),
                      SizedBox(height: 50, width: 400 ,child: RaisedButton.icon(onPressed: () async{
                        setState(() {
                          loading = true;
                        });
                        dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                        if(result==null){setState(() {
                          loading=false;
                        });}
                      },shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)) ,icon: Icon(Icons.login), label: Text('Log-In',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)))
                    ],
                  )
              )
          ),
      ),
    );
  }
}
