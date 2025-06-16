import 'dart:convert';

class PlatformModel {
  String title;
  List<Map<String,dynamic>> folders;

  PlatformModel({required this.title,required this.folders});
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'folders': folders,
    };
  }

  factory PlatformModel.fromMap(Map<String, dynamic> map) {
    return PlatformModel(
      title: map['title'] as String,
      folders: map['folders'] as List<Map<String,dynamic>>
    );
  }

  String toJson() => json.encode(toMap());

  factory PlatformModel.fromJson(String source) => PlatformModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
