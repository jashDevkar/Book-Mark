import 'package:any_link_preview/any_link_preview.dart';
import 'package:bookmark/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomPreviewBuilder extends StatelessWidget {
  final String url;
  const CustomPreviewBuilder({super.key, required this.url});

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
      key: ValueKey(url),
      child: Container(
      
        decoration: kBoxDecoration.copyWith(
          border: BoxBorder.all(
            width: 0,

          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              offset:Offset(0, 1),
              blurRadius: 1
            )
          ]

        ),
        clipBehavior: Clip.hardEdge,
        child: AnyLinkPreview(
          link: url,
          backgroundColor: Colors.white,
          displayDirection: UIDirection.uiDirectionHorizontal,
          cache: const Duration(hours: 12), // longer caching
          placeholderWidget: const _PreviewPlaceholder(),
          errorWidget: const _PreviewError(),
          removeElevation: true,
          bodyMaxLines: 3,
          titleStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
          bodyStyle: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ),
    );
  }
}


class _PreviewPlaceholder extends StatelessWidget {
  const _PreviewPlaceholder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      // decoration: 
      child: const Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ),
    );
  }
}


class _PreviewError extends StatelessWidget {
  const _PreviewError();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      color: Colors.white.withAlpha(250),
      child: const Text(
        'Failed to load preview',
        style: TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }
}
