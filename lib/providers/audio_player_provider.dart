import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';
import 'package:spotify_flutter/helpers/youtube_explode_helper.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();

  List<Track> tracks = [];

  Future initPlayer({String? trackId, String? playlistId}) async {
    if (trackId != null) {
      await _setTrack(trackId);
    } else if (playlistId != null) {
      await _setTracks(playlistId);
    }
    notifyListeners();
    await audioPlayer.play();
  }

  void _clearTracks() {
    tracks.clear();
  }

  Future _setTrack(String trackId) async {
    _clearTracks();
    await SpotifyApiHelper.getIstance().getTrack(trackId).then((value) {
      tracks.add(value);
    });
    await audioPlayer.setUrl(
        await YoutubeExplodeHelper.getIstance().getUrlSong(tracks.first) ?? "");
  }

  Future _setTracks(String playlistId) async {
    _clearTracks();
    await SpotifyApiHelper.getIstance()
        .playlistTracks(playlistId: playlistId)
        .then((value) {
      tracks.addAll(value ?? []);
    });
  }
}
