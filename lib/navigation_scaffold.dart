import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/components/audio_player_bar.dart';
import 'package:spotify_flutter/components/custom_navigation_rail.dart';
import 'package:spotify_flutter/components/tools_bar.dart';
import 'package:spotify_flutter/providers/audio_player_provider.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/home_screen.dart';
import 'package:spotify_flutter/screens/search_screen.dart';
import 'package:spotify_flutter/utils/screen_utils.dart';

class NavigationScaffold extends StatelessWidget {
  final Widget? child;
  const NavigationScaffold({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    final List<CustomNavigationRailDestination> destinations = [
      CustomNavigationRailDestination(
        icon: Icons.home_filled,
        label: "Home",
        selected: true,
        onTap: () {
          navigationProvider.changeCurrentScreen(const HomeScreen());
        },
      ),
      CustomNavigationRailDestination(
        icon: Icons.search_sharp,
        label: "Search",
        onTap: () {
          navigationProvider.changeCurrentScreen(const SearchScreen());
        },
      ),
    ];

    return Scaffold(
      body: LayoutBuilder(builder: (context, screen) {
        return Stack(
          children: [
            Row(
              children: [
                ScreenUtils.isDesktop(context)
                    ? Expanded(
                        child: CustomNavigationRail(
                          leading: Image.asset("assets/logo.png", width: 140),
                          trailing: Wrap(
                            children: [
                              TextButton(
                                child: const Text("Legal"),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: const Text("Privacy Center"),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: const Text("Provacy Policy"),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: const Text("Cookie Settings"),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: const Text("About project"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          destinations: destinations,
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  flex: 4,
                  child: navigationProvider.currentScreen,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: audioPlayerProvider.tracks.isNotEmpty
                  ? const AudioPlayerBar()
                  : const SizedBox(),
            ),
            navigationProvider.showToolsBar
                ? const Align(
                    alignment: Alignment.topRight,
                    child: ToolsBar(),
                  )
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
