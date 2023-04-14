import 'package:flutter/material.dart';

class ImageColor extends StatefulWidget {
  final ImageProvider image;
  final Size size;
  const ImageColor({required this.image, required this.size, super.key});

  @override
  State<ImageColor> createState() => _ImageColorState();
}

class _ImageColorState extends State<ImageColor> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
