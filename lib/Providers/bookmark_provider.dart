
import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/models/platform_model.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BookmarkProvider extends ChangeNotifier {
  final Box _myBox = Hive.box('bookmark');

  final List<String> _allPlatformTitles = [
    'Instagram',
    'Youtube',
    'Twitter',
    'Random',
  ];

  final List<PlatformModel> _allPlatforms = [];

  final List<FolderModel> _allFolders = [];

  final List<UrlModel> _allUrls = [];

  List<String> get allPlatformsTitles => _allPlatformTitles;
  List<PlatformModel> get allPlatforms => _allPlatforms;
  List<FolderModel> get allFolders => _allFolders;


  void saveFoldersInLocalStorage(){
    _myBox.delete('folders');
    List<String> jsonList = _allFolders.map((item)=>item.toJson()).toList();
    _myBox.put('folders', jsonList);
  }


  void retriveAllFolders(){
     List<String?>? foldersString = _myBox.get('folders');
    _allFolders.clear();
    if(foldersString != null){

    _allFolders.addAll(
      foldersString.map((item) => FolderModel.fromJson(item!)),
    );
    notifyListeners();
    }
  }


  List<UrlModel> getSpecificUrl(String? folderName,String platformName){
    if(folderName == null){
      return _allUrls.where((item)=>item.platform == platformName).toList();
    }
    return _allUrls.where((item)=> (item.folderName == folderName)&&(item.platform == platformName)).toList();
  }


  void deleteFolder(FolderModel folderModel){
    _allFolders.remove(folderModel);
    saveFoldersInLocalStorage();
    notifyListeners();
  }

  
  List<FolderModel> getSpecificFolder({required String platformName}) {
    return _allFolders
        .where((item) => item.platformName == platformName)
        .toList();
  }




  void retriveAllPlatforms() {
    List<String> platformString = _myBox.get('platforms');
    _allPlatforms.clear();

    _allPlatforms.addAll(
      platformString.map((item) => PlatformModel.fromJson(item)),
    );
    notifyListeners();
  }

  void saveFolder({required String name,required String platformName}){
    FolderModel folderModel  = FolderModel(name: name, platformName: platformName);
    _allFolders.add(folderModel);
    saveFoldersInLocalStorage();
    notifyListeners();
  }

  void saveAllPlatformData() {
    List<PlatformModel> platform = [
      PlatformModel(
        title: 'Instagram',
        description: 'View all your saved instagram post',
      ),
      PlatformModel(
        title: 'Youtube',
        description: 'View all your saved youtube shorts',
      ),
      PlatformModel(
        title: 'Twitter',
        description: 'View all your book marked twitter post',
      ),
      PlatformModel(
        title: 'Random',
        description: 'View post from random platform',
      ),
    ];

    List<String> platformString = platform
        .map((item) => item.toJson())
        .toList();

    _myBox.put('platforms', platformString);
  }
}
