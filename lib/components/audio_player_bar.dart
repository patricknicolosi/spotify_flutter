import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spotify/spotify.dart' as spotify;

class AudioPlayerBar extends StatelessWidget {
  final spotify.Track track;
  const AudioPlayerBar({
    required this.track,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(24, 24, 24, 1),
        border: Border(
          top: BorderSide(
            color: Colors.white12,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(track.album?.images?.first.url ?? ""),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.name ?? "",
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        track.artists?.map((e) => e.name).join(", ") ?? "",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shuffle_rounded),
                      color: Colors.white70,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.skip_previous_rounded),
                      color: Colors.white70,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.play_circle_fill_rounded),
                      iconSize: 40,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded),
                      color: Colors.white70,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.repeat_rounded),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "0:00",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: 10,
                      width: 440,
                      child: Slider(
                        value: 0.1,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      " ${track.duration!.inMinutes.remainder(60)}:${track.duration!.inSeconds.remainder(60)}",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.volume_up_rounded),
                const SizedBox(width: 5),
                Slider(
                  value: 0.7,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade().slideY(begin: 1, end: 0);
  }
}
