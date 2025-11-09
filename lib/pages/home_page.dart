import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/components/all_save_folder.dart';
import 'package:bookmark/components/remaining_folder_tile.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/models/folder_model.dart';
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
              showFolderOrUrlModel(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
        title: Row(
          spacing: 8,
          children: [const Text('Scroll Vault'), Icon(Icons.storage_rounded)],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: Image(
                image: AssetImage('assets/images/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
            child: Selector<BookmarkProvider, List<FolderModel>>(
              builder: (context, folders, widget) {
                return GridView.builder(
                  itemCount: folders.length + 1,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const AllSaveFolder();
                    } else {
                      FolderModel folder = folders[index - 1];
                      return RemainingFolderTile(
                        folderName: folder.name,
                        folderModel: folder,
                      );
                    }
                  },
                );
              },
              selector: (context, provider) => provider.allFolders,
            ),
          ),
        ],
      ),
    );
  }
}
