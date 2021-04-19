import 'package:build1/cont.dart';
import 'package:build1/jtext.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //
    Cont cont = Cont(
      Cont(JText(data: "dd")));
    print(cont.toJson());
    //
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Cont(JText(data: "hi",)),
      ),
    );
  }
}
