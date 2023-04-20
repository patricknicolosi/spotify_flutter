import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/components/custom_drawer.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/search_results_screen.dart';
import 'package:spotify_flutter/screens/search_screen.dart';
import 'package:spotify_flutter/utils/screen_utils.dart';

class ToolsBar extends StatelessWidget {
  const ToolsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);
    return SizedBox(
      height: 70,
      width: ScreenUtils.isDesktop(context)
          ? ScreenUtils.screenWidth(context) / 1.25
          : ScreenUtils.screenWidth(context),
      child: Align(
        child: AppBar(
          backgroundColor: ScreenUtils.isMobile(context)
              ? const Color.fromRGBO(61, 4, 96, 1)
              : Colors.black,
          elevation: 0,
          toolbarHeight: 65,
          leadingWidth: ScreenUtils.isMobile(context) ? 150 : 0,
          leading: ScreenUtils.isMobile(context)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Image.asset("assets/logo.png"),
                )
              : const SizedBox(),
          title: ScreenUtils.isDesktop(context)
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(const SearchScreen());
                        } else {
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(SearchResultsScreen(
                            searchQuery: value,
                          ));
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(1000.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000.0),
                          ),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                          hintText: "What do you want listen to?",
                          fillColor: Colors.white),
                    ),
                  ),
                )
              : const SizedBox(),
          actions: [
            ScreenUtils.isMobile(context)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        navigationProvider
                            .changeCurrentScreen(const SearchScreen());
                      },
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 8, 10),
              child: FloatingActionButton.extended(
                mouseCursor: SystemMouseCursors.forbidden,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {},
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Log in",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            ScreenUtils.isMobile(context)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const CustomDrawer().animate().fadeIn().slideX(
                                    begin: 1,
                                    end: 0,
                                  ),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ).animate().fade();
  }
}
