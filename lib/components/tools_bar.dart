import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/screens/search_results_screen.dart';

class ToolsBar extends StatelessWidget {
  final bool showSearchField;
  ToolsBar({required this.showSearchField, super.key});

  final TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width / 1.25,
      child: Align(
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          toolbarHeight: 70,
          leadingWidth: 350,
          leading: showSearchField
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: searchEditingController,
                      style: const TextStyle(color: Colors.black),
                      onEditingComplete: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .changeCurrentScreen(SearchResultsScreen(
                          searchQuery: searchEditingController.text,
                        ));
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                          hintText: "Cosa vuoi ascoltare?",
                          fillColor: Colors.white),
                    ),
                  ),
                )
              : const SizedBox(),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {},
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Accedi",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fade();
  }
}
