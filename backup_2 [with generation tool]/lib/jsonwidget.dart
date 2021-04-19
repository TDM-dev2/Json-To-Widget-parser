import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jsonwidget.g.dart';

@JsonSerializable(explicitToJson: true)
abstract class JsonWidget extends StatelessWidget{
  Map<String, dynamic> toJson() => _$JsonWidgetToJson(this);

  
//todo
//add stateful abstract class
  
}