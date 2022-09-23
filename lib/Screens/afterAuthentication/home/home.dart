import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fproject/Database/databasek.dart';
import 'package:fproject/Database/firebaseAuth.dart';
import 'package:fproject/Shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fproject/models/cart.dart';
import 'package:fproject/models/user.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Authservice _auth = Authservice();
  String search = '';
  double quantity = 1;
  @override
  Widget build(BuildContext context) {
    final userr = Provider.of<personalUser?>(context);
    return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(onPressed: () {
                    setState(() {
                      initState();
                    });
                  },
                    icon: Icon(Icons.home),
                    color: Colors.black,
                    hoverColor: Colors.white,),
                  primary: false,
                  actions: <Widget>[
                    TextField(
                      decoration: mydecore.copyWith(hintText: 'Search',
                          constraints: BoxConstraints(
                              minWidth: 100, maxWidth: 125)),
                      onChanged: (val) {
                        search = val;
                      },),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black,),
                      hoverColor: Colors.white,
                      onPressed: () {},),
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black,),
                      hoverColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(context, '/profilescreen');
                        });
                      },),
                    IconButton(hoverColor: Colors.white,onPressed: (){Navigator.pushNamed(context, '/cart');}, icon: Icon(Icons.shopping_cart_rounded,color: Colors.black,)),
                    IconButton(onPressed: () {
                      _auth.signOut();
                    },
                      icon: Icon(Icons.logout, color: Colors.black,),
                      hoverColor: Colors.white,),
                    SizedBox(width: 70)
                  ],
                ),
                body: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('ProductData').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('https://th.bing.com/th/id/OIP.8ruUBa7reZ2GraKwDMuq5wHaNK?pid=ImgDet&rs=1'))),
                      child: GridView(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25),),border: Border.all(color: Colors.black54,width: 4,style: BorderStyle.solid)),
                            //shape:  Border.all(color: Colors.black,width: 2,style: BorderStyle.solid),
                            child: OpenContainer(
                                closedShape : const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                transitionDuration: Duration(seconds: 1),
                                closedBuilder: (BuildContext context, VoidCallback _){
                                  return Container(
                                    //margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25),),border: Border.all(color: Colors.black12,width: 3,style: BorderStyle.solid)),
                                    //shape:  Border.all(color: Colors.black,width: 2,style: BorderStyle.solid),
                                      child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image(image: NetworkImage('https://encrypted-tbn0.gstati'
                                                    'c.com/images?q=tbn:ANd9GcS1BJdGaSjeeUGVLLoeeqXNbw1ZrMMLRqhExw&usqp=CAU'),height: 100,width: 300,),
                                                Text(document['product_Name'],overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                                Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('by ',style: TextStyle(fontWeight: FontWeight.w200,fontSize: 12),),Text(document['product_Seller'],overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),],),
                                                Text(document['product_Description'],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
                                                Text('\$${document['product_Price']}',overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 35),),
                                              ],
                                            ),
                                      )
                                  );
                                },
                                openBuilder: (BuildContext context, VoidCallback _openContainer){
                                  return StatefulBuilder(builder: (context, setState) {
                                    return
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25),),border: Border.all(color: Colors.black12,width: 3,style: BorderStyle.solid)),
                                        //shape:  Border.all(color: Colors.black,width: 2,style: BorderStyle.solid),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image(image: NetworkImage('https://encrypted-tbn0.gstati'
                                                      'c.com/images?q=tbn:ANd9GcS1BJdGaSjeeUGVLLoeeqXNbw1ZrMMLRqhExw&usqp=CAU'),height: 400,width: 400,),
                                                  Text(document['product_Name'],overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 60),),
                                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('by ',style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20),),Text(document['product_Seller'],overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))]),
                                                  Text(document['product_Description'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
                                                  Card(
                                                    elevation: 1.0,
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          FloatingActionButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  quantity--;
                                                                  print(quantity);
                                                                });
                                                              },
                                                              backgroundColor: Colors.white,
                                                              child: Icon(Icons.remove,color: Colors.black87)
                                                          ),
                                                          Text(
                                                            '$quantity',
                                                            style: TextStyle(fontSize: 18.0),
                                                          ),
                                                          FloatingActionButton(
                                                            child: Icon(Icons.add, color: Colors.black87),
                                                            backgroundColor: Colors.white,
                                                            onPressed: () {
                                                              setState(() {
                                                                print(quantity);
                                                                quantity++;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  Text('\$${document['product_Price']}',overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 42),),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(width: 180,height: 50, child: RaisedButton.icon(color: Colors.blue,onPressed: (){}, icon: Icon(Icons.shop), label: const Text('BUY NOW')),),
                                                      SizedBox(width: 180,height: 50, child: RaisedButton.icon(color: Colors.yellowAccent,onPressed: () async{
                                                        await DatabaseService(uid: userr!.uid).addtocart(document['product_Name'], document['product_Seller'], document['product_Description'], document['product_Price'], quantity);
                                                      }, icon: Icon(Icons.add_shopping_cart), label: Text('ADD TO CART')),),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )

                                    );
                                  });

                                }
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
            )
        );
  }

}




// GridView.count(
//     crossAxisCount: 2,
//     // crossAxisSpacing: 15.0,
//     // mainAxisSpacing: 15.0,
//     children: List.generate(pro!.length, (index) {
//       return Padding(padding: EdgeInsets.symmetric(
//           vertical: 10, horizontal: 10),
//         child: ProductCard(products: pro[index]),);
//     }
//     ).toList()
// )