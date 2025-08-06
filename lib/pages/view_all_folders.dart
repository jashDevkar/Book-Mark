
import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/colors.dart';

import 'package:bookmark/components/all_save_folder.dart';
import 'package:bookmark/components/remaining_folder_tile.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllFolders extends StatefulWidget {
  final String platformName;
  const ViewAllFolders({super.key, required this.platformName});

  @override
  State<ViewAllFolders> createState() => _ViewAllFoldersState();
}

class _ViewAllFoldersState extends State<ViewAllFolders> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _folderName = TextEditingController();
  @override
  void dispose() {
    _folderName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              showBottomModal(context, _folderName, widget.platformName);
            },
            child: Text('Add folder', style: kSubAppApp),
          ),
        ],

        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text('Folders', style: kAppBarStyle),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.asset(
              'assets/images/${widget.platformName.toLowerCase()}.png',
              width: 24,
              
            ),
            )
          ],
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
          Consumer<BookmarkProvider>(
            builder: (context, bookMark, child) {
              return GridView(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                ),
                children: [
                  AllSaveFolder(platformName: widget.platformName),
                  ...bookMark
                      .getSpecificFolder(platformName: widget.platformName)
                      .map(
                        (folder) => RemainingFolderTile(
                          platformName: widget.platformName,
                          folderName: folder.name,
                          folderModel: folder,
                        ),
                      ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
