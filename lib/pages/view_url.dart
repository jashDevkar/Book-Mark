import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/colors.dart';
import 'package:bookmark/components/bookmark_tile.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewUrl extends StatefulWidget {
  final String platform;
  final String? folder;
  const ViewUrl({super.key, required this.platform, this.folder});

  @override
  State<ViewUrl> createState() => _ViewUrlState();
}

class _ViewUrlState extends State<ViewUrl> {
  @override
  void initState() {
    super.initState();
  }

  void displayUrls() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              widget.folder?? "All saved",
              style: kAppBarStyle
            ),

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.asset(
              'assets/images/${widget.platform.toLowerCase()}.png',
              height: 24,
              
            ),
            )
          ],
        ),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        
        children: [
        Image.asset('assets/images/image.png',width: double.infinity,height: double.infinity,fit: BoxFit.fitHeight,),
          Consumer<BookmarkProvider>(
        builder: (context, bookMark, child) {
          return ListView(
            children: [
              if (widget.folder == null)
                ...bookMark
                    .getAllUrlOfPlatforms(platformName: widget.platform)
                    .map((item) => BookmarkTile(item: item))
              else
                ...bookMark
                    .getUrlOfFolder(
                      folderName: widget.folder!,
                      platformName: widget.platform,
                    )
                    .map((item) => BookmarkTile(item: item)),
            ],
          );
        },
      ),
        ],
      )
    );
  }
}
