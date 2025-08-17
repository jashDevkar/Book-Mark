import 'package:bookmark/colors.dart';
import 'package:bookmark/pages/view_url.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AllSaveFolder extends StatelessWidget {
  final String platformName;
  const AllSaveFolder({super.key, required this.platformName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ViewUrl(platform: platformName),
          ),
        );
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
