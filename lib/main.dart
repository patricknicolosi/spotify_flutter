import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/helpers/spotify_api_helper.dart';
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
        child: LayoutBuilder(builder: (context, size) {
          return size.minWidth < 800
              ? const Scaffold(
                  body: Center(
                    child: Text("Try in a desktop"),
                  ),
                )
              : const NavigationScaffold();
        }),
      ),
    ),
  );

  SpotifyApiHelper.getIstance().init();
}
