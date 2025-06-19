import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemainingFolder extends StatelessWidget {
  final String folderName;
  final FolderModel folderModel;
  const RemainingFolder({super.key,required this.folderName ,required this.folderModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              GestureDetector(onTap: (){
                showDeleteBottomModal(context,folderModel);
              },child:Icon(Icons.more_vert_rounded))
            ],),
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
      ),
    );
  }
}
