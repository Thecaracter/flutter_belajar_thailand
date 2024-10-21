// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final ImageProvider? imageProvider;
  final Widget? placeholderWidget;
  final Color backgroundColor;
  final PhotoViewComputedScale? minScale;
  final PhotoViewComputedScale? maxScale;

  const ImageViewer({
    Key? key,
    this.imageProvider,
    this.placeholderWidget,
    this.backgroundColor = Colors.black,
    this.minScale,
    this.maxScale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        child: imageProvider != null
            ? PhotoView(
                imageProvider: imageProvider!,
                backgroundDecoration: BoxDecoration(color: backgroundColor),
                minScale: minScale ?? PhotoViewComputedScale.contained,
                maxScale: maxScale ?? PhotoViewComputedScale.covered * 2,
              )
            : Center(
                child: placeholderWidget ??
                    Icon(Icons.image_not_supported,
                        size: 100, color: Colors.grey)),
      ),
    );
  }
}

// Usage example function
void showImageViewer(
  BuildContext context, {
  ImageProvider? imageProvider,
  Widget? placeholderWidget,
  Color backgroundColor = Colors.black,
  PhotoViewComputedScale? minScale,
  PhotoViewComputedScale? maxScale,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ImageViewer(
        imageProvider: imageProvider,
        placeholderWidget: placeholderWidget,
        backgroundColor: backgroundColor,
        minScale: minScale,
        maxScale: maxScale,
      );
    },
  );
}
