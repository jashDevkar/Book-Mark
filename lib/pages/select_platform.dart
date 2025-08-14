import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectPlatform extends StatelessWidget {
  final void Function(String name) onTap;
  const SelectPlatform({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select platform')),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/image.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
            child: Consumer<BookmarkProvider>(
              builder: (context, bookmark, child) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                  ),
                  itemCount: bookmark.allPlatformList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
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

                      child: GestureDetector(
                        onTap: () {
                          onTap(bookmark.allPlatformList[index].title);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Column(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/${bookmark.allPlatformList[index].title}.png',
                                  height: 80,
                                ),
                              ),

                              Text(
                                bookmark.allPlatformList[index].title,
                                style: GoogleFonts.blinker(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
