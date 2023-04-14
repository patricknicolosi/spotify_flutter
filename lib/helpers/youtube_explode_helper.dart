import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeExplodeHelper {
  YoutubeExplodeHelper._privateConstructor();
  static final YoutubeExplodeHelper _instance =
      YoutubeExplodeHelper._privateConstructor();

  static YoutubeExplodeHelper getIstance() {
    return _instance;
  }

  late YoutubeExplode _youtube;

  void init() {
    _youtube = YoutubeExplode();
  }

  Future<String?> getUrlSong(Track track) async {
    if (track.name != null) {
      VideoSearchList result = await _youtube.search.search(track.name ?? "");
      StreamManifest manifest = await _youtube.videos.streamsClient.getManifest(
          result.first.url.substring(
              result.first.url.indexOf("=") + 1, result.first.url.length));
      return manifest.audioOnly[1].url.toString();
    }
    return null;
  }
}
