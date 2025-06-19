// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlatformModel {
  String title;

  String description;
  PlatformModel({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory PlatformModel.fromMap(Map<String, dynamic> map) {
    return PlatformModel(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlatformModel.fromJson(String source) => PlatformModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
