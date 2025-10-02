import 'package:bookmark/colors.dart';
import 'package:bookmark/pages/view_url.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AllSaveFolder extends StatelessWidget {
 
  const AllSaveFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ViewUrl(),
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
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder, size: 40, color: Color(0xff0E1C36)),
            Text(
              'All Saved',
              style: kFoldersTextStyle
            )
          ],
        ),
      ),
    );
  }
}
