import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_flutter/components/collection_card.dart';
import 'package:spotify_flutter/components/track_tile.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';

import 'package:spotify_flutter/providers/audio_player_provider.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/search_screen.dart';
import 'package:spotify_flutter/utils/color_utils.dart';

class ArtistScreen extends StatefulWidget {
  final spotify.Artist artist;
  const ArtistScreen({required this.artist, super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: FutureBuilder<Color>(
        future: ColorUtils.getMainColorFromNetworkImage(
            widget.artist.images!.first.url!),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : snapshot.hasData
                  ? NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) =>
                              <Widget>[
                        SliverAppBar(
                          backgroundColor: snapshot.data!,
                          pinned: true,
                          leading: BackButton(
                            onPressed: () {
                              navigationProvider.changeCurrentScreen(
                                  const SearchScreen(),
                                  showToolsBarValue: true);
                            },
                          ),
                          leadingWidth: 70,
                          expandedHeight:
                              MediaQuery.of(context).size.height / 1.8,
                          toolbarHeight: 70,
                          flexibleSpace: FlexibleSpaceBar(
                            title: innerBoxIsScrolled
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FloatingActionButton.small(
                                        mouseCursor:
                                            SystemMouseCursors.forbidden,
                                        onPressed: () {},
                                        child: const Icon(
                                            Icons.play_arrow_rounded),
                                      ).animate().fade(),
                                      const SizedBox(width: 10),
                                      Text(
                                        widget.artist.name ?? "",
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
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    snapshot.data!.withOpacity(0.5),
                                    BlendMode.darken,
                                  ),
                                  image: NetworkImage(
                                    widget.artist.images!.first.url!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 80, 30, 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30),
                                    Text(
                                      widget.artist.name ?? "",
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
                                      "${widget.artist.followers?.total ?? 0} monthly listener",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
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
                                        mouseCursor:
                                            SystemMouseCursors.forbidden,
                                        onPressed: () {},
                                        child: const Icon(
                                            Icons.play_arrow_rounded),
                                      ),
                                      const SizedBox(width: 15),
                                      IconButton(
                                        mouseCursor:
                                            SystemMouseCursors.forbidden,
                                        iconSize: 30,
                                        icon: const Icon(
                                            Icons.favorite_border_outlined),
                                        onPressed: () {},
                                      ),
                                      const SizedBox(width: 15),
                                      IconButton(
                                        mouseCursor:
                                            SystemMouseCursors.forbidden,
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
                          future: SpotifyApiHelper.getIstance().artistTopTracks(
                              artistId: widget.artist.id ?? ""),
                          builder: (context, snapshot) => !snapshot.hasData
                              ? const SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 120),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Popular",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .fontSize,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DataTable(
                                          dataRowHeight: 70,
                                          columns: [
                                            DataColumn(
                                              label: Text(
                                                '#',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Title',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Album',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Date added',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            const DataColumn(
                                              label: Icon(
                                                Icons.watch_later_outlined,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                          rows: _dataTableRows(snapshot),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        "Album",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .fontSize,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      FutureBuilder<List<spotify.Album>?>(
                                        future: SpotifyApiHelper.getIstance()
                                            .artistAlbums(
                                                artistId:
                                                    widget.artist.id ?? ""),
                                        builder: (context, snapshot) =>
                                            !snapshot.hasData
                                                ? Container()
                                                : SizedBox(
                                                    height: 320,
                                                    child: Scrollbar(
                                                      thumbVisibility: true,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: snapshot
                                                            .data?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return CollectionCard(
                                                            imageUrl: snapshot
                                                                    .data?[
                                                                        index]
                                                                    .images!
                                                                    .first
                                                                    .url ??
                                                                "",
                                                            title: snapshot
                                                                    .data?[
                                                                        index]
                                                                    .name ??
                                                                "",
                                                            subtitle: "Album",
                                                            onTap: () {},
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        "Artist",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .fontSize,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      FutureBuilder<List<spotify.Artist>?>(
                                        future: SpotifyApiHelper.getIstance()
                                            .relatedArtists(
                                                artistId:
                                                    widget.artist.id ?? ""),
                                        builder: (context, snapshot) =>
                                            !snapshot.hasData
                                                ? Container()
                                                : SizedBox(
                                                    height: 320,
                                                    child: Scrollbar(
                                                      thumbVisibility: true,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: snapshot
                                                            .data?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return CollectionCard(
                                                            imageUrl: snapshot
                                                                    .data?[
                                                                        index]
                                                                    .images!
                                                                    .first
                                                                    .url ??
                                                                "",
                                                            title: snapshot
                                                                    .data?[
                                                                        index]
                                                                    .name ??
                                                                "",
                                                            subtitle: "Artist",
                                                            onTap: () {
                                                              Provider.of<NavigationProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .changeCurrentScreen(
                                                                      ArtistScreen(
                                                                artist: snapshot
                                                                        .data![
                                                                    index],
                                                              ));
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                    ],
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

  List<DataRow> _dataTableRows(AsyncSnapshot<List<spotify.Track>?> snapshot) {
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
                onTap: () async {
                  await Provider.of<AudioPlayerProvider>(context, listen: false)
                      .initPlayer(trackId: e.id);
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
