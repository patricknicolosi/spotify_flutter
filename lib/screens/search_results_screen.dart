import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_flutter/components/top_result_card.dart';
import 'package:spotify_flutter/components/collection_card.dart';
import 'package:spotify_flutter/components/track_tile.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';
import 'package:spotify_flutter/providers/audio_player_provider.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/artist_screen.dart';
import 'package:spotify_flutter/screens/playlist_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;
  const SearchResultsScreen({required this.searchQuery, super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      body: FutureBuilder<List<spotify.Page>>(
        future: SpotifyApiHelper.getIstance()
            .search(searchQuery: widget.searchQuery),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            List<spotify.Track> tracks = [];
            List<spotify.Artist> artists = [];
            List<spotify.AlbumSimple> albums = [];
            List<spotify.PlaylistSimple> playlists = [];

            snapshot.data?.forEach((pages) {
              pages.items?.forEach((item) {
                if (item is spotify.Artist) {
                  artists.add(item);
                } else if (item is spotify.Track) {
                  tracks.add(item);
                } else if (item is spotify.AlbumSimple) {
                  albums.add(item);
                } else if (item is spotify.PlaylistSimple) {
                  playlists.add(item);
                }
              });
            });

            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Top result",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Songs",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TopResultCard(
                            artist: artists.first,
                            onTap: () {
                              Provider.of<NavigationProvider>(context,
                                      listen: false)
                                  .changeCurrentScreen(
                                ArtistScreen(
                                  artist: artists.first,
                                ),
                                showToolBarValue: false,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              for (int i = 0; i < tracks.length; i++)
                                TrackTile(
                                    showDuration: true,
                                    showHoverEffect: true,
                                    track: tracks[i],
                                    onTap: () async {
                                      await Provider.of<AudioPlayerProvider>(
                                              context,
                                              listen: false)
                                          .play(tracks[i]);
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Artists",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: artists.length,
                        itemBuilder: (context, index) {
                          return CollectionCard(
                            imageUrl: artists[index].images!.first.url ?? "",
                            title: artists[index].name ?? "",
                            subtitle: "Artista",
                            isArtist: true,
                            onPressed: () {
                              Provider.of<NavigationProvider>(context,
                                      listen: false)
                                  .changeCurrentScreen(
                                ArtistScreen(
                                  artist: artists.first,
                                ),
                                showToolBarValue: false,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Albums",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: albums.length,
                        itemBuilder: (context, index) {
                          return CollectionCard(
                            imageUrl: albums[index].images!.first.url ?? "",
                            title: albums[index].name ?? "",
                            subtitle: "Album",
                            onPressed: () {},
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Playlists",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          return CollectionCard(
                            imageUrl: playlists[index].images!.first.url ?? "",
                            title: playlists[index].name ?? "",
                            subtitle: "Playlist",
                            onPressed: () {
                              Provider.of<NavigationProvider>(context,
                                      listen: false)
                                  .changeCurrentScreen(
                                      PlaylistScreen(
                                        playlist: playlists[index],
                                      ),
                                      showToolBarValue: false);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fade();
          }
        },
      ),
    );
  }
}
