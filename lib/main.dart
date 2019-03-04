import 'package:flutter/material.dart';
import 'package:hello_fluter/ui/LoginPage.dart';
import 'package:hello_fluter/RandomWords.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
////          child: new Text('Hello World'),
//          child: new RandomWords(),
//        ),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new LoginPage(),
    );
  }
}
