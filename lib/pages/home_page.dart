
import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/components/social_media_icons.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:bookmark/pages/view_all_folders.dart';
import 'package:flutter/material.dart';

import 'package:listen_sharing_intent/listen_sharing_intent.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late List<Animation<Offset>> animations;

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

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    animations = List.generate(4, (index) {
      return Tween<Offset>(begin: Offset(-3, 0), end: Offset.zero).animate(
        CurvedAnimation(parent: controller, curve: Interval(index * 0.15, 1,curve: Curves.easeInOutExpo),),
      );
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: AddBookmark()));
          }, icon: Icon(Icons.add))
        ],
        title: Row(
          spacing: 8,
          children: [Text('Scroll Vault'), Icon(Icons.storage_rounded)],
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/image.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
            child: ListView.builder(
              itemCount: Provider.of<BookmarkProvider>(
                context,
              ).allPlatformList.length,

              itemBuilder: (context, index) {
                final item = Provider.of<BookmarkProvider>(
                  context,
                ).allPlatformList[index];
                return SlideTransition(
                  position: animations[index],
                  child: SocialMediaIcons(
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
