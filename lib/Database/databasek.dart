import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fproject/models/products.dart';
import 'package:fproject/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseService {
  final String? uid;

  DatabaseService({ this.uid});

  // Collection Reference
  final CollectionReference UserInformation = FirebaseFirestore.instance
      .collection('UserData');
  final CollectionReference ProductsInformation = FirebaseFirestore.instance
      .collection('ProductData');
  final CollectionReference CartInformation = FirebaseFirestore.instance
      .collection('CartData');

  Future updateUserData(String fname, String lname) async {
    await UserInformation.doc(uid).set({
      'first_name': fname,
      'last_name': lname,
    });
  }
  // UserData from snapshot
  Usercol? _userDataFromSnapshot(DocumentSnapshot snapshot){
    return Usercol(uid: uid?? '',fname: snapshot['first_name']?? '', lname: snapshot['last_name'] ?? '');
  }

  // get user doc stream
  Stream<Usercol?> get userData{
    return UserInformation.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  Future addProduct(String pname,String seller, String description,int price) async{
    await ProductsInformation.add({
      'product_Name': pname,
      'product_Seller': seller,
      'product_Description': description,
      'product_Price': price
    });
  }
  Future addtocart(String pname,String seller, String description,double price,double quantity) async{
    await CartInformation.add({
      'product_Name': pname,
      'product_Seller': seller,
      'product_Description': description,
      'product_Price': price,
      'product_quantity': quantity,
    });
  }
  // //Products list from snapshot
  // List<Products> _productListFromSnapshot(QuerySnapshot snapshot){
  //   print('list of product');
  //   return snapshot.docs.map((doc){
  //     return Products(title: doc.get('product_name') ?? 'asd', description: doc.get('product_Description') ?? 'we', seller: doc.get('product_Seller') ?? 'ty', price: doc.get('product_price') ?? 'qw');
  //   }).toList();
  // }
  // // get Product stream
  // Stream<List<Products>> get ProductInfo {
  //   print('in stream list');
  //   return ProductsInformation.snapshots().map(_productListFromSnapshot);
  //
  // }
}
class Storage{
  final firebase_storage.FirebaseStorage storage= firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async{
    File file =File(filePath);
    try{
      await storage.ref('test/$fileName').putFile(file);
    } catch(e){
      print(e);
    }

  }
  Future<firebase_storage.ListResult> listFiles() async{
    firebase_storage.ListResult results = await storage.ref('test').listAll();
    results.items.forEach((firebase_storage.Reference ref) {
      print('Found File: $ref');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async{
    String downloadURL =await storage.ref('test/$imageName').getDownloadURL();
    return downloadURL;
  }
}