import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_flutter/components/category_card.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';

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
                          return CategoryCard(
                            imageUrl: snapshot.data![index].icons!.first.url!,
                            title: snapshot.data![index].name ?? "",
                            onTap: () {
                              debugPrint("Function not yet supported");
                            },
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
