import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/models/platform_model.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BookmarkProvider extends ChangeNotifier {
  final Box _myBox = Hive.box('bookmark');


  final List<PlatformModel> _allPlatforms = [];

  final List<FolderModel> _allFolders = [];

  final List<UrlModel> _allUrls = [];

  final List<PlatformModel> _platformList = [
      PlatformModel(
        title: 'instagram',
        description: 'View all your saved instagram post',
      ),
      PlatformModel(
        title: 'youtube',
        description: 'View all your saved youtube shorts',
      ),
      PlatformModel(
        title: 'twitter',
        description: 'View all your book marked twitter post',
      ),
      PlatformModel(
        title: 'random',
        description: 'View post from random platform',
      ),
    ];


  List<PlatformModel> get allPlatforms => _allPlatforms;
  List<FolderModel> get allFolders => _allFolders;

  List<PlatformModel> get allPlatformList => _platformList;

  void saveFoldersInLocalStorage() {
    _myBox.delete('folders');
    List<String> jsonList = _allFolders.map((item) => item.toJson()).toList();
    _myBox.put('folders', jsonList);
  }




  /// ------------------ urls -------------------------
  List<UrlModel> getSpecificUrl(String? folderName, String platformName) {
    if (folderName == null) {
      return _allUrls.where((item) => item.platform == platformName).toList();
    }
    return _allUrls
        .where(
          (item) =>
              (item.folderName == folderName) &&
              (item.platform == platformName),
        )
        .toList();
  }


  List<UrlModel> getAllUrlOfPlatforms({required String platformName}) {
    return _allUrls.where((url) => url.platform == platformName).toList();
  }


  List<UrlModel> getUrlOfFolder({
    required String folderName,
    required String platformName,
  }) {
    return _allUrls
        .where(
          (url) => url.platform == platformName && url.folderName == folderName,
        )
        .toList();
  }

  void _saveUrlToLocalStorage(){
    final List<String> jsonList = _allUrls.map((url)=>url.toJson()).toList();
    _myBox.put('urls', jsonList);
  }


  void saveUrl({
    required String url,
    required String platformName,
    String? folder,
    String? note,
  }) {
    _allUrls.add(
      UrlModel(url: url, platform: platformName, folderName: folder,note: note),
    );
    _saveUrlToLocalStorage();
    notifyListeners();
  }

  void editUrl(){
    _saveUrlToLocalStorage();
    notifyListeners();
  }


  void retriveUrls(){
    final List<String>? urls = _myBox.get('urls');
    if(urls != null){
      _allUrls.clear();
      _allUrls.addAll(urls.map((url)=>UrlModel.fromJson(url)));
    }
    notifyListeners();
  }

  void deleteUrl(UrlModel url){
    _allUrls.remove(url);
    _saveUrlToLocalStorage();
    notifyListeners();
  }




  /// =================== folder ==============================
  
  void deleteFolder(FolderModel folderModel) {
    _allFolders.remove(folderModel);
 
    _allUrls.removeWhere((item)=>item.folderName == folderModel.name);
    _saveUrlToLocalStorage();
    saveFoldersInLocalStorage();
    notifyListeners();
  }

  void retriveAllFolders() {
    List<String>? foldersString = _myBox.get('folders');
    _allFolders.clear();
    if (foldersString != null) {
      _allFolders.addAll(
        foldersString.map((item) => FolderModel.fromJson(item)),
      );
      notifyListeners();
    }
  }

  List<FolderModel> getSpecificFolder({required String platformName}) {
    return _allFolders
        .where((item) => item.platformName == platformName)
        .toList();
  }


  /// ===== save folder in specific platform =====
  void saveFolder({required String name, required String platformName}) {
    FolderModel folderModel = FolderModel(
      name: name,
      platformName: platformName,
    );
    _allFolders.add(folderModel);
    saveFoldersInLocalStorage();
    notifyListeners();
  }



  /// ===== get folder count of specific folder =====
  int getPlatformFolderCount({required String platformName}){  
    return _allFolders.where((item)=>item.platformName == platformName).toList().length;
  }


  /// ===== get url count in specific platform ======
  int getUrlPlatformUrlCount({required String platformName}){
    return _allUrls.where((item)=>item.platform == platformName).toList().length;
  }


  

 


  void clearAll(){
    _myBox.clear();
  }
}
