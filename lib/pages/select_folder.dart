import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/colors.dart';

import 'package:bookmark/components/select_folder_tile.dart';
import 'package:bookmark/models/folder_model.dart';

import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectFolder extends StatefulWidget {
  final String platformName;
  const SelectFolder({super.key, required this.platformName});

  @override
  State<SelectFolder> createState() => _SelectFolderState();
}

class _SelectFolderState extends State<SelectFolder> {
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

  int selectedIndex = -1;
  String? folderName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (selectedIndex == -1) {
                showBottomModal(context,);
              } else {
                Navigator.pop(context, folderName);
              }
            },
            child: Text(
              selectedIndex == -1 ? 'Add folder' : 'Select',
              style: kSubAppApp,
            ),
          ),
        ],

        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text('Folders', style: kAppBarStyle),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/${widget.platformName.toLowerCase()}.png',
                width: 24,
              ),
            ),
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
              return GridView.builder(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                ),
                itemCount: bookMark.allFolders.length,
                itemBuilder: (context, index) {
                  final List<FolderModel> folderModel = bookMark.allFolders;
                  final folder = folderModel[index];
                  return SelectFolderTile(
                    folderName: folder.name,
                    folderModel: folder,
                    platformName: widget.platformName,
                    index: index,
                    isSelected: selectedIndex == index,
                    onTap: (selectIndex) {
                      setState(() {
                        if (selectIndex == selectedIndex) {
                          selectedIndex = -1;
                          folderName = null;
                        } else {
                          selectedIndex = selectIndex;
                          folderName = folderModel[selectIndex].name;
                        }
                      });
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
