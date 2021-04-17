import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

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
  final jsonString = '''
{
    "widget" : "Container",
    "child" : {
      "widget" : "Column",
      "children" : [
        {                       
          "widget" : "Text",
          "text" : "Hello"
        },
        {
          "widget" : "Column",
          "children" : [
            {                       
              "widget" : "Text",
              "text" : "Hello"
            },
            {
              "widget" : "Text",
              "text" : "Hi"
            }                             
            ] 
        }                  

        ]
    }
}

  ''';

  Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: load(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              //print(snapshot.data);
              map = snapshot.data;
              return Center(
                  child: JsonWidget(
                map: map,
              ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> load() async {
    Map<String, dynamic> map = await jsonDecode(jsonString);
    return map;
  }
}

//------------------------------------------------------------------------------PASS
class JsonWidget extends StatelessWidget {
  JsonWidget({@required this.map});

  final Map<String, dynamic> map;
  @override
  Widget build(BuildContext context) {
    //print(map);
    switch (map['widget']) {
      case 'Text':
        return JsonText(map);
        break;
      case 'Align':
        return JsonAlign(map);
        break;
      case 'Container':
        return JsonContainer(map);
        break;
      case 'Column':
        return JsonColumn(map);
        break;
      default:
        return nil;
    }
  }
}

//------------------------------------------------------------------------------
class Selector {
  static Widget child(Map<String, dynamic> child) {
    //************************************child has Map */
    //====================*********************************************************child
    switch (child['widget']) {
      //************************************************************************ */ 'widget'   never change
      case 'Text':
        return JsonText(child);
        break;
      case 'Align':
        return JsonAlign(child);
        break;
      case 'Container':
        return JsonContainer(child);
        break;
      case 'Column':
        return JsonColumn(child);
        break;
      default:
        return nil;
    }
  }

  static List<Widget> children(List<dynamic> children) {
    //print(children.length);
    //********************************************children has List */
    //https://stackoverflow.com/questions/65144596/flutter-the-method-add-was-called-on-null
    List<Widget> allChildren = [];
    for (int i = 0; i < children.length; i++) {
      Widget aChild = child(children[i]);
      allChildren.add(aChild);
    }
    return allChildren;
  }
}

//------------------------------------------------------------------------------
class JsonContainer extends StatelessWidget {
  JsonContainer(this.map);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    //print(map['child']);
    Widget child = Selector.child((map['child']));
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
      child: child,
    );
  }
}

//------------------------------------------------------------------------------
class JsonText extends StatelessWidget {
  JsonText(this.map);

  final Map<String, dynamic> map;
  @override
  Widget build(BuildContext context) {
    String text = map['text'];
    return Text("$text");
  }
}

//------------------------------------------------------------------------------
class JsonColumn extends StatelessWidget {
  JsonColumn(
    this.map,
  );

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    List<Widget> sChildren = Selector.children(map['children']);
    print(sChildren);
    return Column(
      children: sChildren,
    );
  }
}

//
//
//
//
//
//
//
//
//
class JsonAlign extends StatelessWidget {
  JsonAlign(
    Map<String, dynamic> properties,
  ) : this.properties = properties;

  final Map<String, dynamic> properties;

  @override
  Widget build(BuildContext context) {
    return Align();
  }
}
