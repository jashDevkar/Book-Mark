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

class _ViewUrlState extends State<ViewUrl> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [Text(widget.folder ?? "All saved", style: kAppBarStyle)],
        ),
        foregroundColor: Colors.white,
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
          Selector<BookmarkProvider, List>(
            selector: (context, provider) {
              return widget.folder == null
                  ? provider.allUrls
                  : provider.getUrlOfFolder(folderName: widget.folder!);
            },
            builder: (context, items, child) {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return BookmarkTile(
              
                    item: items[index],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
