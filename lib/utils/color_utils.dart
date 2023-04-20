import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_flutter/models/palette_generator.dart';

class ColorUtils {
  static Future<Color> getMainColorFromNetworkImage(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return PaletteGenerator.getAverageColor(
        PaletteGenerator.extractPixelsColors(response.bodyBytes, 200));
  }
}
