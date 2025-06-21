import 'package:bookmark/Providers/bookmark_provider.dart';
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
        backgroundColor: Color(0xff0E1C36),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              'Saved',
              style: GoogleFonts.amarante(
                fontWeight: FontWeight.w500,
                fontSize: 26,
              ),
            ),

            Image.asset(
              'assets/images/${widget.platform.toLowerCase()}.png',
              height: 24,
              color: Colors.white,
            ),
          ],
        ),
        foregroundColor: Colors.white,
      ),
      body: Consumer<BookmarkProvider>(
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
    );
  }
}
