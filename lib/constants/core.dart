import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Core {
  String getPlatformName(String url) {
   if(url.contains('x.com')){
    return 'twitter';
   }
   else if(url.contains('instagram.com')){
    return 'instagram';
   }
   else if(url.contains('youtube.com')){
    return 'youtube';
   }
   else{
    return 'random';
   }
  }

  void showAlert(BuildContext context,UrlModel url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                )
              ),
              onPressed: (){
                Navigator.pop(context);
                Provider.of<BookmarkProvider>(context,listen: false).deleteUrl(url);
                
              }, child: Text('Delete')),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
          ],
          content: Text('Are you sure you want to delete this bookmark?'),
        );
      },
    );
  }
}
