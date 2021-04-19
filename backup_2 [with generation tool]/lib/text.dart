import 'package:flutter/cupertino.dart';

extension on Text {
  Map<String, dynamic> _$TextToJson(Text instance) => <String, dynamic>{
      'data': instance.data,
    };
}