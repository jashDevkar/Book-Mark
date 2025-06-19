import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/components/social_media_icons.dart';
import 'package:bookmark/pages/view_all_folders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          spacing: 8,
          children: [
            Text(
              'Book-Mark',
              style: GoogleFonts.caveat(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
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
          ).allPlatformsTitles.length,
          itemBuilder: (context, index) {
            final item = Provider.of<BookmarkProvider>(
              context,
            ).allPlatforms[index];
            return SocialMediaIcons(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ViewAllFolders(platformName: item.title,),
                  ),
                );
              },
              platformName: item.title,
              description: item.description,
            );
          },
        ),
      ),
    );
  }
}
