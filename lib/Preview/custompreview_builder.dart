import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class CustomPreviewBuilder extends StatelessWidget {
  final String url;

  const CustomPreviewBuilder({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return AnyLinkPreview(
      backgroundColor: Colors.white,
      cache: Duration(minutes: 10),
      removeElevation: false,
      key: ValueKey(url),
      link: url,
      displayDirection: UIDirection.uiDirectionHorizontal,
      userAgent: 'WhatsApp/2.21.12.21 A',
    );
  }
}
