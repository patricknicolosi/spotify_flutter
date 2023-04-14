import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';
import 'package:colorlizer/colorlizer.dart' as colorlizer;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 30),
        child: FutureBuilder<List<spotify.Category>>(
          future: SpotifyApiHelper.getIstance().categories(),
          builder: (context, snapshot) => !snapshot.hasData
              ? const SizedBox()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Browse all",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        cacheExtent: 9999,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width > 600
                                  ? MediaQuery.of(context).size.width > 900
                                      ? 300
                                      : 600
                                  : MediaQuery.of(context).size.width,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            color: colorlizer.ColorLizer().getRandomColors(),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 135.0,
                                  left: 135.0,
                                  child: RotationTransition(
                                    turns:
                                        const AlwaysStoppedAnimation(25 / 360),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        snapshot.data![index].icons!.first.url!,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      snapshot.data![index].name.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ).animate().fade(),
        ),
      ),
    );
  }
}
