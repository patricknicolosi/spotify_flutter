import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/components/audio_player_bar.dart';
import 'package:spotify_flutter/components/custom_navigation_rail.dart';
import 'package:spotify_flutter/components/tools_bar.dart';
import 'package:spotify_flutter/providers/audio_player_provider.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/home_screen.dart';
import 'package:spotify_flutter/screens/search_screen.dart';

class NavigationScaffold extends StatelessWidget {
  final Widget? child;
  const NavigationScaffold({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final List<CustomNavigationRailDestination> destinations = [
      CustomNavigationRailDestination(
        icon: const Icon(Icons.home_filled),
        label: const Text("Home"),
        onTap: () {
          Provider.of<NavigationProvider>(context, listen: false)
              .changeCurrentScreen(const HomeScreen());
        },
      ),
      CustomNavigationRailDestination(
        icon: const Icon(Icons.search_sharp),
        label: const Text("Cerca"),
        onTap: () {
          Provider.of<NavigationProvider>(context, listen: false)
              .changeCurrentScreen(const SearchScreen(),
                  showToolBarValue: true);
        },
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomNavigationRail(
                  leading: Image.asset("assets/logo.png", width: 140),
                  trailing: null,
                  destinations: destinations,
                ),
              ),
              Expanded(
                flex: 4,
                child: Provider.of<NavigationProvider>(context, listen: true)
                    .currentScreen,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Provider.of<AudioPlayerProvider>(context, listen: true)
                        .track !=
                    null
                ? AudioPlayerBar(
                    track:
                        Provider.of<AudioPlayerProvider>(context, listen: true)
                            .track!,
                  )
                : const SizedBox(),
          ),
          Provider.of<NavigationProvider>(context, listen: true).showToolBar
              ? Align(
                  alignment: Alignment.topRight,
                  child: ToolsBar(showSearchField: true),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
