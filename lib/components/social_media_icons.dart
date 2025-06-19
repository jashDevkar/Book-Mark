import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
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
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/${platformName.toLowerCase()}.png',
                color: Color(0xff0E1C36),
                height: 75,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(platformName, style: GoogleFonts.caveat(fontSize: 28,fontWeight: FontWeight.bold)),
                  Text(description,style: GoogleFonts.caveat(fontWeight: FontWeight.bold,fontSize: 16),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
