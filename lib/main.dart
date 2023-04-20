import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';
import 'package:spotify_flutter/helpers/youtube_explode_helper.dart';
import 'package:spotify_flutter/navigation_scaffold.dart';
import 'package:spotify_flutter/providers/audio_player_provider.dart';
import 'package:spotify_flutter/providers/navigation_provider.dart';
import 'package:spotify_flutter/theme/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NavigationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AudioPlayerProvider(),
          ),
        ],
        child: const NavigationScaffold(),
      ),
    ),
  );

  SpotifyApiHelper.getIstance().init();
  YoutubeExplodeHelper.getIstance().init();
}
