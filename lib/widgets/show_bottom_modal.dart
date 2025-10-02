import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/constants/constants.dart';
import 'package:bookmark/models/folder_model.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void showBottomModal(BuildContext context) {
  TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    // constraints: BoxConstraints.expand(),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add folder'),
              TextField(
                maxLength: 20,
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter your folder name'),
              ),
              TextButton(
                style: kButtonDecoration,
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    Provider.of<BookmarkProvider>(
                      context,
                      listen: false,
                    ).saveFolder(name: controller.text);
                  }
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text('Add', style: GoogleFonts.roboto()),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showDeleteBottomModal(BuildContext context, FolderModel folder) {
  showModalBottomSheet(
    // constraints: BoxConstraints.expand(),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(50),
        child: TextButton(
          style: TextButton.styleFrom(
            elevation: 4.0,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  icon: Icon(Icons.error_outline_rounded),
                  title: Text('Delete folder?'),
                  content: Text(
                    'Once folder deleted, all saved post related to this folder will also be deleted',
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        elevation: 4.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<BookmarkProvider>(
                          context,
                          listen: false,
                        ).deleteFolder(folder);
                        Navigator.pop(context);
                      },
                      child: Text('Delete'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Delete folder'),
        ),
      );
    },
  );
}

void showFolderOrUrlModel(context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              icon: Icon(Icons.folder),
              style: TextButton.styleFrom(
                elevation: 4.0,

                // backgroundColor: Colors.red,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),

              onPressed: () {
                Navigator.pop(context);
                showBottomModal(context);
              },
              label: Text(
                'Add folder',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(child: Divider()),
                  Text('OR'),
                  Expanded(child: Divider()),
                ],
              ),
            ),

            TextButton.icon(
              style: TextButton.styleFrom(
                elevation: 4.0,
                // backgroundColor: Colors.red,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),

              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: AddBookmark(),
                  ),
                );
              },
              icon: Icon(Icons.link),
              label: Text(
                'Add Url',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
