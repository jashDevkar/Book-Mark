import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/pages/view_url.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              child: ViewUrl(platform: platformName),
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
          color: Color.fromARGB(255, 248, 246, 253),
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
        child: Column(
          children: [
            Stack(
              // fit: StackFit.passthrough,
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
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder, size: 40, color: Color(0xff0E1C36)),
                        Text(
                          folderName,
                          style: GoogleFonts.caveat(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                if (isSelected)
                  Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 130,
                        color: const Color.fromARGB(144, 0, 0, 0),
                        child: Center(
                          child:Icon(Icons.check,size: 80,color: Colors.white,)
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
