import 'package:bookmark/colors.dart';
import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/pages/view_url.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SelectFolderTile extends StatelessWidget {
  final String folderName;
  final FolderModel folderModel;
  final String platformName;
  final void Function(int)? onTap;
  final int index;
  final bool isSelected;
  const SelectFolderTile({
    super.key,
    required this.folderName,
    required this.folderModel,
    required this.platformName,
    required this.index,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(index);
        } else {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ViewUrl(),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(4.5, 4.0),
            ),
          ],
          border: Border.all(color: Color(0xff0E1C36), width: 2),
        ),
        child: Stack(
          children: [
            Column(
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
                Flexible(
                  child: Column(
                    spacing: 10,
                    children: [
                      Icon(Icons.folder, size: 40, color: Color(0xff0E1C36)),
                      Text(folderName, style: kFoldersTextStyle,textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ],
            ),

            if (isSelected)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(144, 0, 0, 0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Icon(Icons.check, size: 85, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
