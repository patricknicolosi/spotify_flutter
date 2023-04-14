import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_flutter/components/track_tile.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';
import 'package:spotify_flutter/models/palette_generator.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_flutter/providers/audio_player_provider.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/home_screen.dart';

class PlaylistScreen extends StatelessWidget {
  final spotify.PlaylistSimple playlist;
  const PlaylistScreen({required this.playlist, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Color>(
        future: _getMainColor(playlist.images!.first.url!),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : snapshot.hasData
                  ? NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) =>
                              <Widget>[
                        SliverAppBar(
                          backgroundColor: snapshot.data!,
                          pinned: true,
                          leadingWidth: 70,
                          expandedHeight:
                              MediaQuery.of(context).size.height / 1.8,
                          toolbarHeight: 70,
                          leading: BackButton(
                            onPressed: () {
                              Provider.of<NavigationProvider>(context,
                                      listen: false)
                                  .changeCurrentScreen(const HomeScreen(),
                                      showToolBarValue: true);
                            },
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            title: innerBoxIsScrolled
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FloatingActionButton.small(
                                        key: UniqueKey(),
                                        onPressed: () {},
                                        child: const Icon(
                                            Icons.play_arrow_rounded),
                                      ).animate().fade(),
                                      const SizedBox(width: 10),
                                      Text(
                                        playlist.name ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ).animate().fade(),
                                    ],
                                  )
                                : null,
                            centerTitle: false,
                            background: Container(
                              decoration: BoxDecoration(
                                color: snapshot.data!,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 80, 30, 40),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        playlist.images!.first.url!,
                                        width: 250,
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Playlist"),
                                        const SizedBox(height: 30),
                                        Text(
                                          playlist.name ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              ),
                                        ),
                                        const SizedBox(height: 30),
                                        Text(
                                          playlist.description ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: _SliverAppBarDelegate(
                            Stack(
                              fit: StackFit.loose,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter,
                                      colors: [
                                        snapshot.data!.withOpacity(0.9),
                                        snapshot.data!.withOpacity(0),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                  child: Row(
                                    children: [
                                      FloatingActionButton(
                                        key: UniqueKey(),
                                        onPressed: () {},
                                        child: const Icon(
                                            Icons.play_arrow_rounded),
                                      ),
                                      const SizedBox(width: 15),
                                      IconButton(
                                        iconSize: 30,
                                        icon: const Icon(
                                            Icons.favorite_border_outlined),
                                        onPressed: () {},
                                      ),
                                      const SizedBox(width: 15),
                                      IconButton(
                                        iconSize: 30,
                                        icon: const Icon(Icons.more_horiz),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      body: SingleChildScrollView(
                        child: FutureBuilder<List<spotify.Track>?>(
                          future: SpotifyApiHelper.getIstance()
                              .playlistTracks(playlistId: playlist.id ?? ""),
                          builder: (context, snapshot) => !snapshot.hasData
                              ? const SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 120),
                                  child: DataTable(
                                    dataRowHeight: 70,
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          '#',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Title',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Album',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Date added',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Icon(
                                          Icons.watch_later_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                    rows: _dataTableRows(snapshot, context),
                                  ),
                                ),
                        ),
                      ),
                    ).animate().fade()
                  : const SizedBox();
        },
      ),
    );
  }

  Future<Color> _getMainColor(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return PaletteGenerator.getAverageColor(
        PaletteGenerator.extractPixelsColors(response.bodyBytes, 200));
  }

  List<DataRow> _dataTableRows(
      AsyncSnapshot<List<spotify.Track>?> snapshot, BuildContext context) {
    int i = 0;
    return snapshot.data!.map<DataRow>(
      (e) {
        i++;
        return DataRow(
          cells: [
            DataCell(
              Text(
                i.toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            DataCell(
              TrackTile(
                track: e,
                onTap: () {
                  Provider.of<AudioPlayerProvider>(context, listen: false)
                      .play(e);
                },
              ),
            ),
            DataCell(
              Text(
                e.album?.name ?? "",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            DataCell(
              Text(
                e.album?.releaseDate ?? "",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            DataCell(
              Text(
                " ${e.duration!.inMinutes.remainder(60)}:${e.duration!.inSeconds.remainder(60)}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    ).toList();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._widget);

  final Widget _widget;

  @override
  double get minExtent => 150;
  @override
  double get maxExtent => 150;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _widget;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
