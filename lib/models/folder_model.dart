
import 'dart:convert';



class FolderModel {
  String name;
  String platformName;
  FolderModel({required this.name, required this.platformName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'platformName': platformName,
    };
  }

  factory FolderModel.fromMap(Map<String, dynamic> map) {
    return FolderModel(
      name: map['name'] as String,
      platformName: map['platformName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FolderModel.fromJson(String source) => FolderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
