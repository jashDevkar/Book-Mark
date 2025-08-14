import 'package:bookmark/Preview/custompreview_builder.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class BookmarkTile extends StatelessWidget {
  final UrlModel item;
  const BookmarkTile({super.key, required this.item});

  void _onShareTextAsXFile(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final shareResult = await SharePlus.instance.share(
        ShareParams(
          subject: 'Url that i saved in my "Scroll Vault" app',
          title: 'Url that i saved in my "Scroll Vault" app',
          text:
              '''Here's the url that i saved in my "Scroll Vault" app\n\nDon't just doom scroll, utilize that knowledge\n\n${item.url}''',
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
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.blueAccent,
            onPressed: (context) {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: AddBookmark(urlModel: item),
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
              Core().showAlert(context, item);
            },
            icon: Icons.delete,
            foregroundColor: Colors.red,
            spacing: 10,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff0E1C36)),
          borderRadius: BorderRadius.circular(10),

          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(4.5, 4.0),
            ),
          ],
        ),
        child: Column(
          spacing: 10,
          children: [
            CustomPreviewBuilder(url: item.url),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [Text('Note:- '), Text(item.note ?? "")],
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
            ),
          ],
        ),
      ),
    );
  }
}
