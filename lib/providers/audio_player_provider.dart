import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

class AudioPlayerProvider extends ChangeNotifier {
  Track? track;

  void play(Track newTrack) async {
    track = newTrack;
    notifyListeners();
  }
}
