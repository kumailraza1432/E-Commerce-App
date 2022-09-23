import 'package:flutter/material.dart';
import 'package:fproject/Screens/afterAuthentication/account/profile.dart';
import 'package:fproject/Screens/afterAuthentication/account/viewOrders.dart';
import 'package:fproject/Screens/afterAuthentication/home/cart.dart';
import 'package:fproject/Screens/afterAuthentication/home/home.dart';
import 'package:fproject/Screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fproject/models/user.dart';
import 'package:fproject/wrapper/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:fproject/Screens/afterAuthentication/account/addProductPage.dart';


import 'Database/firebaseAuth.dart';
import 'Screens/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print('-- WidgetsFlutterBinding.ensureInitialized');
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: "AIzaSyDptb0cT238PrZ3YJVEsAKVCi5HXhVMxC0", // Your apiKey
    appId: "XXX", // Your appId
    messagingSenderId: "XXX", // Your messagingSenderId
    projectId: "kumail-project-6181b", // Your project// Id
    storageBucket: "kumail-project-6181b.appspot.com",
    databaseURL: 'https://kumail-project-6181b.firebasedatabase.app',
  ));
  print('-- main: Firebase.initializeApp');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<personalUser?>.value(value: Authservice().user,
    initialData: null,
    child: MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black)),
        fontFamily: 'Nunito'),
      //home: Wrapper(),
      initialRoute: '/',
      routes: {
        '/':(context)=> Wrapper(),
        '/homescreen':(context)=> HomeScreen(),
        '/profilescreen':(context)=> Profile(),
        '/addproduct':(context)=> AddProduct(),
        '/vieworders':(context)=> ViewOrders(),
        '/cart':(context)=> Cart(),
      },
    ));
  }
}