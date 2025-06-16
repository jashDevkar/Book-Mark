import 'dart:developer';

import 'package:bookmark/models/platform_model.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<UrlModel> _myAllUrls = [];


  final List<PlatformModel> _myAllPlatform=[];

  final List<String> jsonList = [];

  final Box _myBox = Hive.box('bookmark');

  List<UrlModel> get allUrls => _myAllUrls;

  void storeInLocal() {
    _myBox.clear();
    jsonList.clear();
    for (UrlModel url in _myAllUrls) {
      jsonList.add(url.toJson());
    }

    _myBox.put('urls', jsonList);
  }

  void retriveDataFromLocal() {
    _myAllUrls.clear();
    jsonList.clear();
    jsonList.addAll(_myBox.get('urls') as List<String>);
  
    for (String url in jsonList) {
      UrlModel urlModel = UrlModel.fromJson(url);
      _myAllUrls.add(urlModel);
    }
  }

  void addUrl({required String url, required String platform, String? note}) {
    UrlModel urlModel = UrlModel(url: url, platform: platform, note: note);
    _myAllUrls.add(urlModel);
    storeInLocal();
    notifyListeners();
  }


  void removeUrl(UrlModel url){
    _myAllUrls.remove(url);
    storeInLocal();
    notifyListeners();
  }

  List<UrlModel> getPlatformSpecificUrls(String platform) {
    return _myAllUrls.where((url) => url.platform == platform).toList();
  }
}
