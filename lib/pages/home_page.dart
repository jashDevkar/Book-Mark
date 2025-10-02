import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/components/all_save_folder.dart';
import 'package:bookmark/components/remaining_folder_tile.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeft,
              //     child: AddBookmark(),
              //   ),
              // );

              showFolderOrUrlModel(context);
            },
            icon: Icon(Icons.add),
          ),
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
            child: Consumer<BookmarkProvider>(
              builder: (context, bookMarkProvider, child) {
                return GridView(
                  // itemCount: Provider.of<BookmarkProvider>(context).allFolders.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                  ),
                  children: [
                    AllSaveFolder(),

                    ...bookMarkProvider.allFolders.asMap().entries.map(
                      (entry) => RemainingFolderTile(
                        folderName: entry.value.name,
                        folderModel: entry.value,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
