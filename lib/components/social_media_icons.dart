import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SocialMediaIcons extends StatelessWidget {
  final void Function() onTap;
  final String platformName;
  final String description;

  const SocialMediaIcons({
    super.key,
    required this.onTap,
    required this.platformName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color:  Colors.white,
          boxShadow: [
           
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(4.0, 4.0),
            ),
          ],
          border: Border.all(color: Color(0xff0E1C36), width: 2),
        ),
        child: Row(
          spacing: 14,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.asset(
                height: 65,
                'assets/images/${platformName.toLowerCase()}.png',
                // color: Colors.blue.shade900,
                
                              ),
              )
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  // === platform name ===
                  Text(
                    platformName,
                    style:GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                
                  
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        '${Provider.of<BookmarkProvider>(context).getPlatformFolderCount(platformName: platformName.toLowerCase())} Folders',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,fontSize: 12
                        ),
                      ),
                      Text(
                        '${Provider.of<BookmarkProvider>(context).getUrlPlatformUrlCount(platformName: platformName.toLowerCase())} Urls',
                         style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,fontSize: 12
                        ),
                  
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
