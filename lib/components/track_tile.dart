import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart' as spotify;

class TrackTile extends StatefulWidget {
  final spotify.Track track;
  final Function onTap;
  final bool showDuration;
  final bool showHoverEffect;
  const TrackTile({
    required this.onTap,
    required this.track,
    this.showDuration = false,
    this.showHoverEffect = false,
    super.key,
  });

  @override
  State<TrackTile> createState() => _TrackTileState();
}

class _TrackTileState extends State<TrackTile> {
  bool _isMouseHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
      child: ListTile(
        onTap: () {
          widget.onTap();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Text(widget.track.name ?? ""),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.track.explicit ?? false
                ? const Icon(Icons.explicit_rounded)
                : const SizedBox(),
            const SizedBox(width: 5),
            Text(
              widget.track.artists!.map((e) => e.name).join(", "),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        leading: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                widget.track.album?.images?.first.url ?? "",
                filterQuality: FilterQuality.none,
                colorBlendMode: _isMouseHover && widget.showHoverEffect
                    ? BlendMode.darken
                    : null,
                color: _isMouseHover && widget.showHoverEffect
                    ? Colors.black54
                    : null,
              ),
              _isMouseHover && widget.showHoverEffect
                  ? const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        trailing: widget.showDuration
            ? Text(
                " ${widget.track.duration!.inMinutes.remainder(60)}:${widget.track.duration!.inSeconds.remainder(60)}",
                style: const TextStyle(color: Colors.grey),
              )
            : null,
      ),
    );
  }
}
