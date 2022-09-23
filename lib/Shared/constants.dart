import 'package:flutter/material.dart';

const mydecore= InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 3)),
  constraints: BoxConstraints(minWidth: 160,maxWidth: 450,minHeight: 50,maxHeight: 80)
);
//AppBar myappbar = AppBar(backgroundColor: Colors.black45, elevation: 0,centerTitle: true,);


class myappbar extends AppBar{
  myappbar():super(
    backgroundColor: Colors.black45, elevation: 0,centerTitle: true, title: Text('Firebase App')
  );
}
