import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_flutter/helpers/youtube_explode_helper.dart';

class AudioPlayerProvider extends ChangeNotifier {
  Track? currentPlayingTrack;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future play(Track track) async {
    await _audioPlayer.setUrl(
        await YoutubeExplodeHelper.getIstance().getUrlSong(track) ?? "");
    _setCurrentPlayingTrack(track);
    await _audioPlayer.play();
  }

  Future pause() async {
    await _audioPlayer.pause();
  }

  void _setCurrentPlayingTrack(Track track) {
    currentPlayingTrack = track;
    notifyListeners();
  }
}
