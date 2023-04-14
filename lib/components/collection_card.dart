import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CollectionCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final Function() onPressed;
  final bool isArtist;
  const CollectionCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onPressed,
    this.isArtist = false,
    super.key,
  });

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  bool _isMouseHover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: MouseRegion(
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
        child: GestureDetector(
          onTap: () {
            widget.onPressed();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 320,
            width: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _isMouseHover
                  ? Colors.grey.withOpacity(0.13)
                  : Colors.grey.withOpacity(0.05),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: widget.isArtist
                              ? BorderRadius.circular(1000)
                              : BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: widget.isArtist
                              ? BorderRadius.circular(1000)
                              : BorderRadius.circular(5),
                          child: Image(
                            image: NetworkImage(widget.imageUrl),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                        ),
                      ),
                    ],
                  ),
                  _isMouseHover
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 60, 8, 0),
                            child: FloatingActionButton(
                              heroTag: UniqueKey().toString(),
                              child: const Icon(Icons.play_arrow),
                              onPressed: () {},
                            ),
                          ),
                        )
                          .animate()
                          .fade(duration: const Duration(milliseconds: 150))
                          .slideY(
                              begin: 0.1,
                              end: -0.015,
                              duration: const Duration(milliseconds: 150))
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
