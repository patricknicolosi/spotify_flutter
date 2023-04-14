import 'dart:async';
import 'package:spotify/spotify.dart';

class SpotifyApiHelper {
  SpotifyApiHelper._privateConstructor();
  static final SpotifyApiHelper _instance =
      SpotifyApiHelper._privateConstructor();

  static SpotifyApiHelper getIstance() {
    return _instance;
  }

  final String _clientId = "244b8a93ce324e35af6721c3d93128b6";
  final String _clientSecret = "1c42e634162e479ca3a60bc9560fffb6";
  late final SpotifyApiCredentials _credentials;
  late final SpotifyApi _spotify;

  Future<void> init() async {
    _credentials = SpotifyApiCredentials(_clientId, _clientSecret);
    _spotify = SpotifyApi(_credentials);
  }

  Future<List<PlaylistSimple>?> featuredPlaylists() async {
    Page<PlaylistSimple> featuredPlaylists =
        await _spotify.playlists.featured.first();
    return featuredPlaylists.items?.toList();
  }

  Future<List<AlbumSimple>?> newReleases() async {
    Page<AlbumSimple> newReleases =
        await _spotify.browse.getNewReleases(country: "it").first(6);
    return newReleases.items?.toList();
  }

  Future<List<Track>?> playlistTracks({required String playlistId}) async {
    Page<Track> tracks = await _spotify.playlists
        .getTracksByPlaylistId(playlistId)
        .getPage(50, 0);
    return tracks.items?.toList() ?? [];
  }

  Future<List<Track>> artistTopTracks({required String artistId}) async {
    Iterable<Track> tracks =
        await _spotify.artists.getTopTracks(artistId, "it");
    return tracks.toList();
  }

  Future<List<Album>> artistAlbums({required String artistId}) async {
    Iterable<Album> albums =
        await _spotify.artists.albums(artistId, country: "it").all(10);
    return albums.toList();
  }

  Future<List<Artist>> relatedArtists({required String artistId}) async {
    Iterable<Artist> relatedArtists =
        await _spotify.artists.relatedArtists(artistId);
    return relatedArtists.toList();
  }

  Future<List<Category>> categories() async {
    Iterable<Category> categories =
        await _spotify.categories.list(country: "it", locale: "it").all();
    return categories.toList();
  }

  Future<List<Page<dynamic>>> search(
      {required String searchQuery, List<SearchType>? searchTypes}) async {
    return await _spotify.search
        .get(searchQuery, types: searchTypes ?? SearchType.all, market: "it")
        .first(4);
  }
}
