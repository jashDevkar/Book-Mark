// import 'dart:developer';


// import 'package:bookmark/Providers/bookmark_provider.dart';
// import 'package:bookmark/components/bookmark_tile.dart';
// import 'package:bookmark/models/url_model.dart';

// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';

// import 'package:provider/provider.dart';

// class ViewAllSaved extends StatefulWidget {
//   final String platform;
//   const ViewAllSaved({super.key, required this.platform});

//   @override
//   State<ViewAllSaved> createState() => _ViewAllSavedState();
// }

// class _ViewAllSavedState extends State<ViewAllSaved> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   void displayUrls() {
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff0E1C36),
//         title: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           spacing: 10,
//           children: [
//             Text(
//               'Saved',
//               style: GoogleFonts.amarante(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 26,
//               ),
//             ),

//             Image.asset(
//               'assets/images/${widget.platform}.png',
//               height: 24,
//               color: Colors.white,
//             ),
//           ],
//         ),
//         foregroundColor: Colors.white,
//       ),
//       body: ListView.builder(
//         itemCount: Provider.of<BookmarkProvider>(
//           context,
//         ).getPlatformSpecificUrls(widget.platform).length,
//         itemBuilder: (context, index) {
//           final BookmarkProvider provider = Provider.of<BookmarkProvider>(
//             context,
//           );

//           final UrlModel item = provider.getPlatformSpecificUrls(
//             widget.platform,
//           )[index];

//           return BookmarkTile(item: item);
//         },
//       ),
//     );
//   }
// }
