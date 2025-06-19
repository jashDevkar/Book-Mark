import 'package:bookmark/Providers/bookmark_provider.dart';

import 'package:bookmark/components/all_save_folder.dart';
import 'package:bookmark/components/remaining_folder.dart';
import 'package:bookmark/widgets/show_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            child: Text(
                          'Add folder',
                          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
                          ),
                        )
          ),
        ],

        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              'Folders',
              style: GoogleFonts.caveat(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                letterSpacing: 1.5,
              ),
            ),
             Image.asset('assets/images/${widget.platformName.toLowerCase()}.png',width: 28,color: Colors.white,)
          ],
        ),
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookMark, child) {
          
          return GridView(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15,
              crossAxisCount: 2,
            ),
            children: [
              AllSaveFolder(),
              ...bookMark
                  .getSpecificFolder(platformName: widget.platformName)
                  .map(
                    (folder) => RemainingFolder(
                      folderName: folder.name,
                      folderModel: folder,
                    ),
                  ),
                  
            ],
          );
        },
      ),
    );
  }
}
