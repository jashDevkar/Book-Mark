import 'dart:developer';

import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/components/remaining_folder_tile.dart';
import 'package:bookmark/components/select_folder_tile.dart';
import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/pages/view_all_folders.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              if(selectedIndex == -1 ){
                showBottomModal(context, _folderName, widget.platformName);
              }
              else{
                Navigator.pop(context,folderName);
              }
            },
            child: Text(
              selectedIndex == -1 ? 'Add folder':'Select',
              style: GoogleFonts.amarante(
                color: Colors.white,
                fontSize: 16,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],

        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              'Folders',
              style: GoogleFonts.amarante(
                // fontWeight: FontWeight.bold,
                // fontSize: 28,
                // letterSpacing: 1.5,
              ),
            ),
            Image.asset(
              'assets/images/${widget.platformName.toLowerCase()}.png',
              width: 24,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookMark, child) {
          return GridView.builder(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15,
              crossAxisCount: 2,
            ),
            itemCount: bookMark
                .getSpecificFolder(platformName: widget.platformName)
                .length,
            itemBuilder: (context, index) {
              final List<FolderModel> folderModel = bookMark.getSpecificFolder(
                platformName: widget.platformName,
              );
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
    );
  }
}
