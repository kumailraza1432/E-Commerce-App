import 'package:flutter/material.dart';
import 'package:fproject/Database/firebaseAuth.dart';
import 'package:fproject/Shared/constants.dart';

class ViewOrders extends StatefulWidget {
  const ViewOrders({Key? key}) : super(key: key);

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  String search ='';
  Authservice _auth = Authservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }, icon: Icon(Icons.home),color: Colors.black,hoverColor: Colors.white,),
        primary: false,
        actions: <Widget>[
          TextField(
            decoration: mydecore.copyWith(hintText: 'Search',constraints: BoxConstraints(minWidth: 100,maxWidth: 125)),
            onChanged: (val){
              search=val;
            },),
          IconButton(
            icon: Icon(Icons.search, color: Colors.black,), hoverColor: Colors.white, onPressed: () {},),
          IconButton(
            icon: Icon(Icons.person, color: Colors.black,), hoverColor: Colors.white, onPressed: () {Navigator.pop(context);}),
          IconButton(onPressed: (){_auth.signOut();}, icon: Icon(Icons.logout,color: Colors.black,),hoverColor: Colors.white,),
          SizedBox(width: 70)
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder:(BuildContext context, int index){
            return ListTile(
              title: Text('asdfas'),
              subtitle: Text('asdvi kdas'),
              trailing: Text('jn nudsn c'),
            );
          }),
    );
  }
}
