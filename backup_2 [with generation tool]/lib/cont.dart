import 'package:build1/jsonwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cont.g.dart';

@JsonSerializable(explicitToJson: true)
class Cont extends JsonWidget {
  Cont(this.child);
  final JsonWidget child;

  Map<String, dynamic> toJson() => _$ContToJson(this);

  @override
  Widget build(BuildContext context) {
    print("build rus");
    return Container(child: this.child,);
  }
}
