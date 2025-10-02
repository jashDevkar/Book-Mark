import 'package:bookmark/colors.dart';
import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/pages/view_url.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RemainingFolderTile extends StatelessWidget {
  final String folderName;
  final FolderModel folderModel;
  
  
  const RemainingFolderTile({
    super.key,
    required this.folderName,
    required this.folderModel,

    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      
          Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ViewUrl(folder: folderName,),
          ),
        );
        
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color:   const Color.fromARGB(197, 255, 255, 255),
          
          border: Border.all(color: Color(0xff0E1C36), width: 1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showDeleteBottomModal(context, folderModel);
                  },
                  child: Icon(Icons.more_vert_rounded),
                ),
              ],
            ),
            Expanded(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.folder, size: 40, color: Color(0xff0E1C36)),
                  Expanded(child: Text(
                    folderName,
                    style:kFoldersTextStyle,
                    textAlign: TextAlign.center,
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
