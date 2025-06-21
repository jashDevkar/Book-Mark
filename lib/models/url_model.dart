// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UrlModel {

  String url;
  String platform;
  String? note;
  String? folderName;
  DateTime? date  = DateTime.now();

  UrlModel({required this.url,required this.platform,this.note,DateTime? date,this.folderName}):date = date?? DateTime.now();


  



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'platform': platform,
      'note': note,
      'folderName': folderName,
    };
  }

  factory UrlModel.fromMap(Map<String, dynamic> map) {
    return UrlModel(
      url: map['url'] as String,
      platform: map['platform'] as String,
      note: map['note'] != null ? map['note'] as String : null,
      folderName: map['folderName'] != null ? map['folderName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UrlModel.fromJson(String source) => UrlModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



