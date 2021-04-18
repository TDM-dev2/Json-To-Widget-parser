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


class WidgetSelector {
    /*
      ------------------------------------------------child map-------------------------------------------------------------------------
      "child" : 
      //child is a map (widget).
      //In here child is Column widget.
      //child (Column)start
        {
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
      //child end
    */
  static Widget child(Map<String, dynamic> child) { 
    /*
    select child type
    child['widget'] : 'Column'   ->   JsonColumn
    */
    switch (child['widget']) {
      case 'Text':
        /*
      child (column) map is pass for all the widget
      
      */
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
//------------------------------------------------------------------------------------------------------------------------------------
    /*
      Example code-------------------
      "children" : [
            {                             //child-1
              "widget" : "Text",
              "text" : "Hello"
            },
            {                             //child-2
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

        children is a list of widgets  
     */
  static List<Widget> children(List<dynamic> children) {

//------------------------------------------------------------------------------------------------------------------------------------
    List<Widget> allChildren = [];
    /*
    Error:- 
            If you try to add items for declared list -> The method '[]' was called on null.
                                                         Receiver: null
                                                         Tried calling: []("widget")
    Reason:- 
            List<Widget> allChildren;       ->  Only declare a variable with type list.
                                                This is a empty variable (no list assign for that variable).
            List<Widget> allChildren = [];  ->  Declare variable & store list object.
                                                Now this variable contains a list object,so we can do list method operation on that
                                                    eg:- .add,.length   etc
    Solved:- 
            Assign list object for that variable.
    */
    //https://stackoverflow.com/questions/65144596/flutter-the-method-add-was-called-on-null
//
//
//-------------------------------------------------------------------------------------------------------------------------------------
    
    for (int i = 0; i < children.length; i++) {
      /*
      Select one item() from list (List<dynamic>) and pass it to child() function
      ex:-
      children[1]   =  one child(map/widget) in the list.
      */
      Widget aChild = child(children[i]);
      allChildren.add(aChild);
    }
    /*
    Return list of widgets  [widget1,widget2....]
    */
    return allChildren;
  }
}

//-------------------------------------------------------------------------------------------------------------------------------------
class JsonContainer extends StatelessWidget {

  /*
  map variable =  {
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
  */
  JsonContainer(this.map);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    //properties are first assign for variables before composition
    //eg:-  child, decoration, width
    Widget child = WidgetSelector.child((map['child']));
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
    List<Widget> sChildren = WidgetSelector.children(map['children']);
    print(sChildren);
    return Column(
      children: sChildren,
    );
  }
}

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
