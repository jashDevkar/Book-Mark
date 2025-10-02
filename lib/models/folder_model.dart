
import 'dart:convert';



class FolderModel {
  String name;
  FolderModel({required this.name,});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory FolderModel.fromMap(Map<String, dynamic> map) {
    return FolderModel(
      name: map['name'] as String,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory FolderModel.fromJson(String source) => FolderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
