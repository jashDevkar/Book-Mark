import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class CustomPreviewBuilder extends StatefulWidget {
  final String url;

  const CustomPreviewBuilder({super.key, required this.url});

  @override
  State<CustomPreviewBuilder> createState() => _CustomPreviewBuilderState();
}

class _CustomPreviewBuilderState extends State<CustomPreviewBuilder> {
  late Future<Widget> preview;

  @override
  void initState() {
    super.initState();
    preview = _loadPreview();
  }

  Future<Widget> _loadPreview() async {
    return AnyLinkPreview(
      backgroundColor: Colors.white,
      cache: const Duration(minutes: 10),
      removeElevation: false,
      key: ValueKey(widget.url),
      link: widget.url,
      displayDirection: UIDirection.uiDirectionHorizontal,
      userAgent: 'WhatsApp/2.21.12.21 A',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: preview,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 80,
            width: double.infinity,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Failed to load preview", style: TextStyle(color: Colors.red)),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
