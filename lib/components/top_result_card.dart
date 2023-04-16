import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spotify/spotify.dart';

class TopResultCard extends StatefulWidget {
  final Artist artist;
  final Function onTap;
  const TopResultCard({required this.artist, required this.onTap, super.key});

  @override
  State<TopResultCard> createState() => _TopResultCardState();
}

class _TopResultCardState extends State<TopResultCard> {
  bool _isMouseHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          _isMouseHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isMouseHover = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _isMouseHover
              ? Colors.grey.withOpacity(0.13)
              : Colors.grey.withOpacity(0.05),
        ),
        child: InkWell(
          onTap: () {
            widget.onTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(widget.artist.images?.first.url ?? ""),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        widget.artist.name ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .fontSize,
                        ),
                      ),
                    ),
                    const Chip(label: Text("Artist")),
                  ],
                ),
                _isMouseHover
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 140, 0, 0),
                          child: FloatingActionButton(
                            mouseCursor: SystemMouseCursors.forbidden,
                            heroTag: UniqueKey().toString(),
                            child: const Icon(Icons.play_arrow),
                            onPressed: () {},
                          ),
                        ),
                      )
                        .animate()
                        .fade(duration: const Duration(milliseconds: 150))
                        .slideY(
                            begin: 0.4,
                            end: -0.015,
                            duration: const Duration(milliseconds: 150))
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
