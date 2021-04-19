import 'package:build1/jsonwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_annotation/json_annotation.dart';
part 'jtext.g.dart';

@JsonSerializable(explicitToJson: true)
class JText extends JsonWidget {
  JText({
    required this.data,
  });

  String data;

  Map<String, dynamic> toJson() => _$JTextToJson(this);

  @override
  Widget build(BuildContext context) {
    print("buil run");
    return Text(this.data);
  }
}
