import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/colors.dart';
import 'package:bookmark/components/bookmark_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewUrl extends StatefulWidget {
 
  final String? folder;
  const ViewUrl({super.key, this.folder});

  @override
  State<ViewUrl> createState() => _ViewUrlState();
}

class _ViewUrlState extends State<ViewUrl> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(widget.folder ?? "All saved", style: kAppBarStyle),

            // ClipRRect(
            //   borderRadius: BorderRadiusGeometry.circular(10),
            //   child: Image.asset(
            //     'assets/images/${widget.platform.toLowerCase()}.png',
            //     height: 24,
            //   ),
            // ),
          ],
        ),
        foregroundColor: Colors.white,
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
              final List items = widget.folder == null
                  ? bookMark.allUrls
                  : bookMark.getUrlOfFolder(
                      folderName: widget.folder!,
                     
                    );

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return BookmarkTile(item: items[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
