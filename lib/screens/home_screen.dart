import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_flutter/components/collection_card.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/playlist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomRight,
          begin: Alignment.topLeft,
          stops: const [0.2, 0.9],
          colors: [
            Colors.black.withOpacity(0.6),
            Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Le playlist di Spotify",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
              ),
              const SizedBox(height: 30),
              FutureBuilder<List<spotify.PlaylistSimple>?>(
                future: SpotifyApiHelper.getIstance().featuredPlaylists(),
                builder: (context, snapshot) => !snapshot.hasData
                    ? Container()
                    : SizedBox(
                        height: 320,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return CollectionCard(
                              imageUrl:
                                  snapshot.data?[index].images!.first.url ?? "",
                              title: snapshot.data?[index].name ?? "",
                              subtitle: snapshot.data?[index].description ?? "",
                              onPressed: () {
                                Provider.of<NavigationProvider>(context,
                                        listen: false)
                                    .changeCurrentScreen(
                                        PlaylistScreen(
                                          playlist: snapshot.data![index],
                                        ),
                                        showToolBarValue: false);
                              },
                            );
                          },
                        ),
                      ),
              ),
              const SizedBox(height: 30),
              Text(
                "Focus",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
              ),
              const SizedBox(height: 30),
              FutureBuilder<List<spotify.PlaylistSimple>?>(
                future: SpotifyApiHelper.getIstance().featuredPlaylists(),
                builder: (context, snapshot) => !snapshot.hasData
                    ? Container()
                    : SizedBox(
                        height: 320,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return CollectionCard(
                              imageUrl:
                                  snapshot.data?[index].images!.first.url ?? "",
                              title: snapshot.data?[index].name ?? "",
                              subtitle: snapshot.data?[index].description ?? "",
                              onPressed: () {
                                Provider.of<NavigationProvider>(context,
                                        listen: false)
                                    .changeCurrentScreen(
                                        PlaylistScreen(
                                          playlist: snapshot.data![index],
                                        ),
                                        showToolBarValue: false);
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
