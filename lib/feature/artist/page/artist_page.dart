// ignore_for_file: unused_import

import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/feature/artist/widget/myexpensiontile_artist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  final PlayerController controller = Get.put(PlayerController());
  late List<MapEntry<String, int>> sortedArtistNpic;

  @override
  void initState() {
    super.initState();
    sortedArtistNpic = controller.artistNpic.entries.toList()
      ..sort((a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: sortedArtistNpic.length,
        itemBuilder: (context, index) {
          String artistName = sortedArtistNpic[index].key;

          String currentLetter = artistName[0].toUpperCase();

          String? previousLetter;
          if (index > 0) {
            previousLetter = sortedArtistNpic[index - 1].key[0].toUpperCase();
          }

          bool showHeader = index == 0 || currentLetter != previousLetter;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader)
                Container(
                  alignment: Alignment.center,
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: Colors.black87,
                  child: Text(
                    currentLetter,
                    style: Fontstyle.navfont(22, Colors.white),
                  ),
                ),

              FutureBuilder<Uint8List?>(
                future: controller.audioQuery.queryArtwork(
                  sortedArtistNpic[index].value,
                  ArtworkType.AUDIO,
                  format: ArtworkFormat.PNG,
                  size: 1000,
                ),
                builder: (context, artworkSnapshot) {
                  List<String> albums =
                      controller.artisNalbum[artistName] ?? [];

                  List<String> artistNamesongnum = controller
                      .artistNsongnumber
                      .values
                      .elementAt(index);

                  return MyexpensiontileArtist(
                    atistimage: artworkSnapshot.data,
                    artistName: artistName,
                    songNum: artistNamesongnum.length,
                    albumNum: albums.length,
                    albumName: albums,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
