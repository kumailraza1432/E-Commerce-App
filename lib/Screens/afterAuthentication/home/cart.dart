import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fproject/Database/firebaseAuth.dart';
import 'package:fproject/Shared/constants.dart';
import 'package:fproject/Shared/loader.dart';
import 'package:fproject/models/cart.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  double quantity= 1;
  String search = '';
  Authservice _auth = Authservice();
  List<CartItems> io = CartItems(productname: 'productname',
      sellername: 'sellername',
      description: 'description',
      quantity: 2,
      price: 2).items();
  List<CartItems> asd = [
    CartItems(productname: 'productname2',
        sellername: 'sellername2',
        description: 'description2',
        quantity: 2,
        price: 4),
    CartItems(productname: 'productname3',
        sellername: 'sellername3',
        description: 'description3',
        quantity: 2,
        price: 3)
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('CartData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loader();
          }
          else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(onPressed: () {
                    setState(() {
                      Navigator.pop(context);
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
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/profilescreen');
                        });
                      },),
                    IconButton(hoverColor: Colors.white,
                        onPressed: () {
                          initState();
                        },
                        icon: Icon(
                          Icons.shopping_cart_rounded, color: Colors.black,)),
                    IconButton(onPressed: () {
                      _auth.signOut();
                    },
                      icon: Icon(Icons.logout, color: Colors.black,),
                      hoverColor: Colors.white,),
                    SizedBox(width: 70)
                  ],
                ),
                body: GridView(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 870,
                      childAspectRatio: 6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                20),), border: Border.all(color: Colors.black12,
                            width: 2,
                            style: BorderStyle.solid)),
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25),),border: Border.all(color: Colors.black54,width: 4,style: BorderStyle.solid)),
                        //shape:  Border.all(color: Colors.black,width: 2,style: BorderStyle.solid),
                        child: Column(
                          children: [
                            ListTile(
                              leading: SizedBox(height: 180,
                                width: 80,
                                child: Container(
                                  width: 200,
                                  height: 500,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://encrypted-tbn0.gstati'
                                                  'c.com/images?q=tbn:ANd9GcS1BJdGaSjeeUGVLLoeeqXNbw1ZrMMLRqhExw&usqp=CAU'))),),),
                              title: Row(children: [
                                Text(document['product_Name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Text(' by ', style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 10)),
                                Text(document['product_Seller'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                              ],),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Text(
                                      'Price: \$${document['product_Price']}   ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),),),
                                  SizedBox(width: 25,
                                    height: 30,
                                    child: FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            //quantity=document['product_quantity'];
                                            quantity--;
                                          });
                                        },
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                            Icons.remove, color: Colors.black87)
                                    ),),
                                  Text(
                                    '${quantity}',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  SizedBox(width: 25,
                                    height: 30,
                                    child: FloatingActionButton(
                                      child: Icon(
                                          Icons.add, color: Colors.black87),
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                    ),)
                                ],
                              ),
                              trailing: Text(
                                  'Total Price: \$${document['product_Price'] *
                                      document['product_quantity']}'),
                            )
                          ],
                        )

                    );
                  }).toList(),
                ),
                bottomSheet: SizedBox(
                  height: 100, child: Container(color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Subtotal:   ', style: TextStyle(color: Colors
                              .white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),),
                          Text('\$${subtotal()}', style: TextStyle(color: Colors
                              .white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Total:   ', style: TextStyle(color: Colors
                              .white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                          Text('\$${total()}', style: TextStyle(color: Colors
                              .white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Order Placed')));
                          }, icon: Icon(Icons.check_circle,
                            color: Colors.white,))
                        ],
                      )
                    ],
                  ),
                ),
                )
            );
          }
        });
  }

  double subtotal() {
    double r = 0;
    for (int i = 0; i < asd.length; i++) {
      double e = asd[i].quantity * asd[i].price;
      r = r + e;
    }
    return r;
  }

  int total() {
    double r = subtotal() * 1.2;
    return r.round();
  }




// ListView.builder(
//     itemCount: asd.length,
//     itemBuilder: (BuildContext contex, Index) {
//       return ListTile(
//         leading: SizedBox(height: 80,
//           width: 80,
//           child: Container(
//             decoration: BoxDecoration(image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: NetworkImage('https://encrypted-tbn0.gstati'
//                     'c.com/images?q=tbn:ANd9GcS1BJdGaSjeeUGVLLoeeqXNbw1ZrMMLRqhExw&usqp=CAU'))),),),
//         title: Row(children: [
//           Text('${asd[Index].productname}',
//               style: TextStyle(fontWeight: FontWeight.bold,
//                   fontSize: 15)),
//           Text(' by ', style: TextStyle(fontWeight: FontWeight.w200,
//               fontSize: 10)),
//           Text('${asd[Index].sellername}',
//               style: TextStyle(fontWeight: FontWeight.bold,
//                   fontSize: 15))
//         ],),
//         subtitle: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//               child: Text('Price: \$${asd[Index].price}   ',
//                 style: TextStyle(
//                     fontSize: 15, fontWeight: FontWeight.bold),),),
//             SizedBox(width: 25, height: 30, child: FloatingActionButton(
//                 onPressed: () {
//                   setState(() {
//                     asd[Index].quantity--;
//                   });
//                 },
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.remove, color: Colors.black87)
//             ),),
//             Text(
//               '${asd[Index].quantity}',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             SizedBox(width: 25, height: 30, child: FloatingActionButton(
//               child: Icon(Icons.add, color: Colors.black87),
//               backgroundColor: Colors.white,
//               onPressed: () {
//                 setState(() {
//                   asd[Index].quantity++;
//                 });
//               },
//             ),)
//           ],
//         ),
//         trailing: Text(
//             'Total Price: \$${asd[Index].price * asd[Index].quantity}'),
//       );
//     });


}