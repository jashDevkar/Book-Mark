import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/models/folder_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void showBottomModal(
  BuildContext context,
  TextEditingController controller,
  String platformName,
) {
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
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter your folder name'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    Provider.of<BookmarkProvider>(
                      context,
                      listen: false,
                    ).saveFolder(
                      name: controller.text,
                      platformName: platformName,
                    );
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
        padding: EdgeInsets.symmetric(vertical: 50),
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  icon:Icon(Icons.error_outline_rounded),
                  title: Text('Delete folder?'),
                  content: Text('Once folder deleted, all saved post will also be deleted'),
                  actions: [
                    TextButton(onPressed: () {
                      Provider.of<BookmarkProvider>(context,listen: false).deleteFolder(folder);
                      Navigator.pop(context);
                    }, child: Text('Delete')),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('Cancel')),
                  ],
                );
              },
            );
          },
          child: Text('Delete folder ${folder.name}'),
        ),
      );
    },
  );
}
