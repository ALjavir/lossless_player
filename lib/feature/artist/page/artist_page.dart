import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.cachedSongs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Artist found!", style: TextStyle(fontSize: 20)),
                ElevatedButton(
                  onPressed: () async {
                    controller.showdiolog(context);
                  },
                  child: Text(
                    "Select Folder",
                    style: Fontstyle.songN(25, Colors.black, FontWeight.normal),
                  ),
                ),
              ],
            ),
          );
        } else {
          final sortedArtistNpic = controller.artistNpic.entries.toList()
            ..sort(
              (a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()),
            );

          return Stack(
            children: [
              ListView.builder(
                itemCount: sortedArtistNpic.length,
                itemBuilder: (context, index) {
                  String artistName = sortedArtistNpic[index].key;

                  String currentLetter = artistName[0].toUpperCase();

                  String? previousLetter;
                  if (index > 0) {
                    previousLetter = sortedArtistNpic[index - 1].key[0]
                        .toUpperCase();
                  }

                  bool showHeader =
                      index == 0 || currentLetter != previousLetter;

                  return SliverStickyHeader(
                    header: Container(
                      height: 40,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(currentLetter, style: Fontstyle.navfont(22)),
                    ),

                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showHeader)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                //horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                currentLetter,
                                style: Fontstyle.navfont(
                                  22,
                                  // fontWeight: FontWeight.bold,
                                ),
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
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}
