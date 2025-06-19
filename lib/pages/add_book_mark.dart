// import 'package:bookmark/Preview/custompreview_builder.dart';

// import 'package:bookmark/Providers/bookmark_provider.dart';
// import 'package:bookmark/constants/core.dart';

// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';

// import 'package:provider/provider.dart';

// class AddBookmark extends StatefulWidget {
 
//   final String? url;
//   const AddBookmark({super.key, this.url});

//   @override
//   State<AddBookmark> createState() => _AddBookmarkState();
// }

// class _AddBookmarkState extends State<AddBookmark> {
//   final TextEditingController _urlController = TextEditingController();
//   final TextEditingController _noteController = TextEditingController();

//   @override
//   void dispose() {
//     _urlController.dispose();
//     _noteController.dispose();
//     super.dispose();
//   }

//   bool showPreview = false;

//   String? platform ;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.url != null) {
//       _urlController.text = widget.url!;
//       platform = Core().getPlatformName(widget.url!);
//     }
//   }

//   void toggleShowPreview() {
//     setState(() {
//       showPreview = !showPreview;
//     });
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff0E1C36),
//         title: Text(
//           'Add Book-Mark',
//           style: GoogleFonts.amarante(
//             fontWeight: FontWeight.w500,
//             fontSize: 26,
//           ),
//         ),
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
//           child: Column(
//             spacing: 16,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.bookmark_add_rounded,
//                 size: 60,
//                 color: Color(0xff0E1C36),
//               ),

//               //url field
//               TextField(
//                 controller: _urlController,

//                 decoration: InputDecoration(hintText: 'Enter your url'),
//               ),

//               //show preview when
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 10,
//                   bottom: showPreview ? 10 : 0,
//                   right: showPreview ? 10 : 0,
//                 ),
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         //
//                         ///show this text only when user has not tapped on show preview icon
//                         if (!showPreview)
//                           Text('Show preview', style: GoogleFonts.amarante()),

//                         ///show this text when user has tapped on show preview icon and show preview is enabled
//                         if (showPreview)
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _urlController.text = _urlController.text;
//                               });
//                             },
//                             icon: Icon(Icons.refresh),
//                           ),

//                         IconButton(
//                           style: IconButton.styleFrom(
                                                     
                            
//                           ),
//                           onPressed: () {
//                             if (_urlController.text.isNotEmpty) {
//                               toggleShowPreview();
//                             }
//                           },
//                           icon: Icon(
//                             !showPreview
//                                 ? Icons.keyboard_arrow_down_outlined
//                                 : Icons.keyboard_arrow_up_rounded,
//                           ),
//                         ),
//                       ],
//                     ),

//                     if (showPreview)
//                       CustomPreviewBuilder(url: _urlController.text)
                 
//                   ],
//                 ),
//               ),

//               TextField(
//                 maxLines: null,
//                 minLines: 1,
//                 maxLength: 100,
//                 controller: _noteController,
//                 decoration: InputDecoration(hintText: 'Enter your note'),
//               ),

//               TextButton(
//                 style: TextButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadiusGeometry.circular(10),
//                   ),
//                   foregroundColor: Colors.white,
//                   backgroundColor: Color(0xff0E1C36),
//                 ),
//                 onPressed: () {
//                   if (_urlController.text.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Enter a valid url')),
//                     );
//                   } else {
//                     Provider.of<BookmarkProvider>(
//                       context,
//                       listen: false,
//                     ).addUrl(
//                       url: _urlController.text,
//                       platform: platform?? Core().getPlatformName(_urlController.text),
//                       note: _noteController.text
//                     );

//                     _urlController.clear();
//                     _noteController.clear();
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text('Add'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
