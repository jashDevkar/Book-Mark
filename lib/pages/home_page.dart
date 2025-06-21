import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/components/social_media_icons.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:bookmark/pages/view_all_folders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listen_sharing_intent/listen_sharing_intent.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _sharedFile = <SharedMediaFile>[];

  @override
  void initState() {
    super.initState();

    ReceiveSharingIntent.instance.getInitialMedia().then((val) {
      _sharedFile.clear();
      _sharedFile.addAll(val);

      final List<Map<String, dynamic>> mysharedItem = _sharedFile
          .map((item) => item.toMap())
          .toList();
      if (mysharedItem.isNotEmpty) {
        String url = mysharedItem[0]['path'];
        if (mounted) {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: AddBookmark(
                url: url,
                platform: Core().getPlatformName(url),
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 8,
          children: [
            Text(
              'Book-Mark',
              style: GoogleFonts.amarante(
            
              ),
            ),
            Icon(Icons.bookmark_add_outlined),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
        child: ListView.builder(
          itemCount: Provider.of<BookmarkProvider>(
            context,
          ).allPlatformList.length,
          itemBuilder: (context, index) {
            final item = Provider.of<BookmarkProvider>(
              context,
            ).allPlatformList[index];
            return SocialMediaIcons(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ViewAllFolders(platformName: item.title),
                  ),
                );
              },
              platformName:
                  item.title[0].toUpperCase() + item.title.substring(1),
              description: item.description,
            );
          },
        ),
      ),
    );
  }
}
