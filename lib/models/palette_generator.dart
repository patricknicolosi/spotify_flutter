import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as imagelib;

class PaletteGenerator {
  static Color getAverageColor(List<Color> colors) {
    int r = 0, g = 0, b = 0;

    for (int i = 0; i < colors.length; i++) {
      r += colors[i].red;
      g += colors[i].green;
      b += colors[i].blue;
    }

    r = r ~/ colors.length;
    g = g ~/ colors.length;
    b = b ~/ colors.length;

    return Color.fromRGBO(r, g, b, 1);
  }

  static Color abgrToColor(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    int hex = (argbColor & 0xFF00FF00) | (b << 16) | r;
    return Color(hex);
  }

  static List<Color> extractPixelsColors(
      Uint8List? bytes, int noOfPixelsPerAxis) {
    List<Color> colors = [];

    List<int> values = bytes!.buffer.asUint8List();
    imagelib.Image? image = imagelib.decodeImage(values);

    List<int?> pixels = [];

    int? width = image?.width;
    int? height = image?.height;

    int xChunk = width! ~/ (noOfPixelsPerAxis + 1);
    int yChunk = height! ~/ (noOfPixelsPerAxis + 1);

    for (int j = 1; j < noOfPixelsPerAxis + 1; j++) {
      for (int i = 1; i < noOfPixelsPerAxis + 1; i++) {
        int? pixel = image?.getPixel(xChunk * i, yChunk * j);
        pixels.add(pixel);
        colors.add(abgrToColor(pixel!));
      }
    }

    return colors;
  }
}
