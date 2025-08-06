import 'package:bookmark/Preview/custompreview_builder.dart';
import 'package:bookmark/constants/core.dart';
import 'package:bookmark/models/url_model.dart';
import 'package:bookmark/pages/add_book_mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class BookmarkTile extends StatelessWidget {
  final UrlModel item;
  const BookmarkTile({super.key, required this.item});

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
              Navigator.push(context, PageTransition(
                type: PageTransitionType.rightToLeft,
                child: AddBookmark(urlModel: item),
              ));
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Note:- ', style: GoogleFonts.amarante()),
                  Expanded(child: Text(item.note ?? "")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
