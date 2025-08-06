import 'package:bookmark/Preview/custompreview_builder.dart';

import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:bookmark/pages/select_folder.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

class AddBookmark extends StatefulWidget {
  final String? url;
  final String? platform;
  final UrlModel? urlModel;
  const AddBookmark({super.key, this.url, this.platform, this.urlModel});

  @override
  State<AddBookmark> createState() => _AddBookmarkState();
}

class _AddBookmarkState extends State<AddBookmark> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool showPreview = false;

  String? platform ;

  @override
  void initState() {
    super.initState();
    if (widget.url != null) {
      _urlController.text = widget.url!;
      platform = platform ?? Core().getPlatformName(widget.url!);
    }
    if (widget.urlModel != null) {
      platform = widget.urlModel!.platform;
      _urlController.text = widget.urlModel!.url;
      _noteController.text = widget.urlModel!.note ?? "";
      finalFolderName = widget.urlModel!.folderName ?? "All saved";
    }
  }

  void toggleShowPreview() {
    setState(() {
      showPreview = !showPreview;
    });
  }

  String? folderName;
  String? finalFolderName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book-Mark'),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),

                  child: Image.asset(
                    'assets/images/$platform.png',
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //url field
              TextField(
                controller: _urlController,

                decoration: InputDecoration(hintText: 'Enter your url'),
              ),

              //show preview when
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  bottom: showPreview ? 10 : 0,
                  right: showPreview ? 10 : 0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///show this text only when user has not tapped on show preview icon
                        if (!showPreview)
                          Text('Show preview', style: GoogleFonts.amarante()),

                        ///show this text when user has tapped on show preview icon and show preview is enabled
                        if (showPreview)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _urlController.text = _urlController.text;
                              });
                            },
                            icon: Icon(Icons.refresh),
                          ),

                        IconButton(
                          style: IconButton.styleFrom(),
                          onPressed: () {
                            if (_urlController.text.isNotEmpty) {
                              toggleShowPreview();
                            }
                          },
                          icon: Icon(
                            !showPreview
                                ? Icons.keyboard_arrow_down_outlined
                                : Icons.keyboard_arrow_up_rounded,
                          ),
                        ),
                      ],
                    ),

                    if (showPreview)
                      CustomPreviewBuilder(url: _urlController.text),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      folderName = await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: SelectFolder(platformName: platform!),
                        ),
                      );

                      setState(() {
                        finalFolderName = folderName;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          if (finalFolderName == null) Text('Select folder'),
                          Text(finalFolderName ?? ''),
                          if (finalFolderName != null) Icon(Icons.add),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              TextField(
                maxLines: null,
                minLines: 1,
                maxLength: 100,
                controller: _noteController,
                decoration: InputDecoration(hintText: 'Enter your note'),
              ),

              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue.shade700,
                ),
                onPressed: () {
                  if (_urlController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Enter a valid url')),
                    );
                  } else if (widget.urlModel != null &&
                      _urlController.text.isNotEmpty) {
                    widget.urlModel!.url = _urlController.text;

                    widget.urlModel!.folderName = finalFolderName;
                    widget.urlModel!.note = _noteController.text;

                    Provider.of<BookmarkProvider>(
                      context,
                      listen: false,
                    ).editUrl();

                    _urlController.clear();
                    _noteController.clear();
                    Navigator.pop(context);
                  } else {
                    Provider.of<BookmarkProvider>(
                      context,
                      listen: false,
                    ).saveUrl(
                      url: _urlController.text,
                      platformName:
                          platform ??
                          Core().getPlatformName(_urlController.text),
                      note: _noteController.text,
                      folder: finalFolderName,
                    );
                    _urlController.clear();
                    _noteController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
