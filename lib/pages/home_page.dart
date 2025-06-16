import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/components/social_media_icons.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:bookmark/pages/view_all_saved.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';s
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

    getData();

    ///receive sharing
    ReceiveSharingIntent.instance.getInitialMedia().then((val) {
      _sharedFile.clear();
      _sharedFile.addAll(val);

      final List<Map<String, dynamic>> mysharedItem = _sharedFile
          .map((item) => item.toMap())
          .toList();
      if (mysharedItem.isNotEmpty) {
        String url = mysharedItem[0]['path'];
        navigateToAddBookmark( url: url);
      }
    });
  }

  void getData() {
    Provider.of<BookmarkProvider>(
      context,
      listen: false,
    ).retriveDataFromLocal();
  }

  void navigateToAddBookmark({ required String url}) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: AddBookmark(url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff0E1C36),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: AddBookmark(),
            ),
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xfffaf7ff),
      appBar: AppBar(
        backgroundColor: Color(0xff0E1C36),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              'Book-mark',
              style: GoogleFonts.amarante(
                fontWeight: FontWeight.w500,
                fontSize: 26,
              ),
            ),

            Icon(Icons.bookmark_add_outlined, size: 26),
          ],
        ),
        foregroundColor: Colors.white,
      ),
      // bottomNavigationBar: Container(
      //   color: Color(0xff0e1c36),
      //   padding: EdgeInsets.only(bottom: 20, top: 15, left: 20, right: 20),
      //   child: GNav(
      //     rippleColor: Colors.grey.shade800,
      //     hoverColor: Colors.grey.shade700,
      //     haptic: true, // haptic feedback
      //     tabBorderRadius: 24,

      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     curve: Curves.easeOutExpo,
      //     duration: Duration(milliseconds: 300),
      //     gap: 8,
      //     color: Colors.grey[600],
      //     activeColor: Colors.white,
      //     iconSize: 24,
      //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      //     tabs: [
      //       GButton(icon: Icons.bookmark_add_outlined, text: 'Bookmarks'),
      //       GButton(icon: Icons.file_download_rounded, text: 'Download'),
      //       GButton(icon: Icons.thumb_up_alt, text: 'Feedback'),
      //     ],
      //   ),
      // ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        children: [
          SocialMediaIcons(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ViewAllSaved(platform: 'instagram'),
                ),
              );
            },
            platformName: 'Instagram',
            description:
                'View all post saved on instagram which are either saved using a note or without a note',
          ),
          SocialMediaIcons(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ViewAllSaved(platform: 'twitter'),
                ),
              );
            },
            platformName: 'Twitter',
            description:
                'View all bookmarks of twitter which are either saved using notes or without a note',
          ),
          SocialMediaIcons(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ViewAllSaved(platform: 'twitter'),
                ),
              );
            },
            platformName: 'Youtube',
            description:
                'View all bookmarks of twitter which are either saved using notes or without a note',
          ),
        ],
      ),
    );
  }
}
