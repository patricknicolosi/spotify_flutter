import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/providers/audio_player_provider.dart';

class AudioPlayerBar extends StatefulWidget {
  const AudioPlayerBar({
    super.key,
  });

  @override
  State<AudioPlayerBar> createState() => _AudioPlayerBarState();
}

class _AudioPlayerBarState extends State<AudioPlayerBar> {
  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: true);
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
                  Image.network(audioPlayerProvider
                          .tracks.first.album?.images?.first.url ??
                      ""),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audioPlayerProvider.tracks.first.name ?? "",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        audioPlayerProvider.tracks.first.artists
                                ?.map((e) => e.name)
                                .join(", ") ??
                            "",
                        overflow: TextOverflow.ellipsis,
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
                    mouseCursor: SystemMouseCursors.forbidden,
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ).animate().fade(),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<Object>(
                    stream: audioPlayerProvider.audioPlayer.playingStream,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            mouseCursor: SystemMouseCursors.forbidden,
                            icon: const Icon(Icons.shuffle_rounded),
                            color: Colors.white70,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            mouseCursor: SystemMouseCursors.forbidden,
                            icon: const Icon(Icons.skip_previous_rounded),
                            color: Colors.white70,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            icon: snapshot.data != true
                                ? const Icon(Icons.play_circle_fill_rounded)
                                : const Icon(
                                    Icons.pause_circle_filled_outlined),
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () async {
                              if (audioPlayerProvider.audioPlayer.playing) {
                                await audioPlayerProvider.audioPlayer.pause();
                              } else {
                                await audioPlayerProvider.audioPlayer.play();
                              }
                            },
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            mouseCursor: SystemMouseCursors.forbidden,
                            icon: const Icon(Icons.skip_next_rounded),
                            color: Colors.white70,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            mouseCursor: SystemMouseCursors.forbidden,
                            icon: const Icon(Icons.repeat_rounded),
                            onPressed: () {},
                          ),
                        ],
                      );
                    }),
                StreamBuilder<Duration>(
                    stream: audioPlayerProvider.audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${snapshot.data?.inMinutes.remainder(60)}:${snapshot.data?.inSeconds.remainder(60)}",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .fontSize,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              height: 10,
                              width: 440,
                              child: Slider(
                                value:
                                    snapshot.data?.inMilliseconds.toDouble() ??
                                        0.0,
                                min: 0.0,
                                max: audioPlayerProvider
                                        .audioPlayer.duration?.inMilliseconds
                                        .toDouble() ??
                                    0.0,
                                onChangeStart: (value) async {
                                  await audioPlayerProvider.audioPlayer.pause();
                                },
                                onChangeEnd: (value) async {
                                  await audioPlayerProvider.audioPlayer.play();
                                },
                                onChanged: (value) async {
                                  await audioPlayerProvider.audioPlayer
                                      .seek(value.milliseconds);
                                },
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              " ${audioPlayerProvider.audioPlayer.duration?.inMinutes.remainder(60)}:${audioPlayerProvider.audioPlayer.duration?.inSeconds.remainder(60)}",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .fontSize,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        );
                      }
                    })
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder<double>(
                stream: audioPlayerProvider.audioPlayer.volumeStream,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.volume_up_rounded),
                      const SizedBox(width: 5),
                      Slider(
                        min: 0.0,
                        max: 1.0,
                        value: snapshot.data ?? 1.0,
                        onChanged: (value) async {
                          await audioPlayerProvider.audioPlayer
                              .setVolume(value);
                        },
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    ).animate().fade().slideY(begin: 1, end: 0);
  }
}
