// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UrlModel {

  String url;
  String platform;
  String? note;
  String? folderName;
  DateTime? date  = DateTime.now();

  UrlModel({required this.url,required this.platform,this.note,DateTime? date,this.folderName}):date = date?? DateTime.now();


  


}



