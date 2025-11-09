import 'package:bookmark/Preview/custompreview_builder.dart';
import 'package:bookmark/constants/constants.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class BookmarkTile extends StatefulWidget {
  final UrlModel item;
  const BookmarkTile({super.key, required this.item});

  @override
  State<BookmarkTile> createState() => _BookmarkTileState();
}

class _BookmarkTileState extends State<BookmarkTile>
    with AutomaticKeepAliveClientMixin {
  void _onShareTextAsXFile(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final shareResult = await SharePlus.instance.share(
        ShareParams(
          subject: 'Url that i saved in my "Scroll Vault" app',
          title: 'Url that i saved in my "Scroll Vault" app',
          text:
              '''Here's the url that i saved in my "Scroll Vault" app\n\nDon't just doom scroll, utilize that knowledge\n\n${widget.item.url}''',
        ),
      );

      if (shareResult.status == ShareResultStatus.success) {
        scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Something went wroong')),
      );
    }
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        'Shared successfully',
        style: GoogleFonts.blinker(color: Color(0xfffaf7ff)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            onPressed: (context) {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: AddBookmark(urlModel: widget.item),
                ),
              );
            },
            icon: Icons.edit,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Core().showAlert(context, widget.item);
            },
            icon: Icons.delete,
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            spacing: 10,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.only(bottom: 10),
        decoration: kBoxDecoration,
        child: Column(
          spacing: 10,
          children: [
            CustomPreviewBuilder(url: widget.item.url),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text('Note:-'),
                        Flexible(child: Text(widget.item.note ?? "")),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: Image.asset(
                          "assets/images/${widget.item.platform}.png",
                          width: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onShareTextAsXFile(context);
                        },
                        child: Icon(Icons.share, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
