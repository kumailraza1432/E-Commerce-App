import 'package:flutter/material.dart';
import 'package:fproject/models/cart.dart';

class Cart_Tile extends StatefulWidget {
  const Cart_Tile({Key? key}) : super(key: key);

  @override
  State<Cart_Tile> createState() => _Cart_TileState();
}

class _Cart_TileState extends State<Cart_Tile> {
  List<CartItems> asd =[CartItems(productname: 'productname', sellername: 'sellername', description: 'description', quantity: 2, price: 3),CartItems(productname: 'productname2', sellername: 'sellername2', description: 'description2', quantity: 23, price: 43),CartItems(productname: 'productname3', sellername: 'sellername3', description: 'description3', quantity: 26, price: 36)];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: asd.length,
        itemBuilder: (BuildContext contex, Index){
          return ListTile(
            leading: SizedBox(height: 80,width: 80,child: Container(decoration: BoxDecoration(image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('https://encrypted-tbn0.gstati'
                    'c.com/images?q=tbn:ANd9GcS1BJdGaSjeeUGVLLoeeqXNbw1ZrMMLRqhExw&usqp=CAU'))),),),
            title: Row(children: [Text('${asd[Index].productname}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),Text(' by ',style: TextStyle(fontWeight: FontWeight.w200,fontSize: 10)),Text('${asd[Index].sellername}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))],),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),child: Text('Price: ${asd[Index].price}   ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                SizedBox(width: 25,height: 30 ,child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        asd[Index].quantity--;
                      });
                    },
                    backgroundColor: Colors.white,
                    child: Icon(Icons.remove,color: Colors.black87)
                ),),
                Text(
                  '${asd[Index].quantity}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 25,height: 30,child: FloatingActionButton(
                  child: Icon(Icons.add, color: Colors.black87),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      asd[Index].quantity++;
                    });
                  },
                ),)
              ],
            ),
            trailing: Text('Total Price: ${asd[Index].price * asd[Index].quantity}'),
          );
        });
  }
}
