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
                    style: Fontstyle.songN(25, Colors.black),
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.artistNpic.length,
            itemBuilder: (context, index) {
              String artistName = controller.artistNpic.keys.elementAt(index);
              int picID = controller.artistNpic.values.elementAt(index);
              String LartistName = controller.artisNalbum.keys.elementAt(index);
              List<String> albums = controller.artisNalbum[artistName] ?? [];
              List<String> artistNamesongnum = controller
                  .artistNsongnumber
                  .values
                  .elementAt(index);
              return FutureBuilder<Uint8List?>(
                future: controller.audioQuery.queryArtwork(
                  picID,
                  ArtworkType.AUDIO,
                  format: ArtworkFormat.JPEG,
                  quality: 1000,
                ),
                builder: (context, artworkSnapshot) {
                  //List  albumName = controller.artisNalbum.values.indexed;
                  if (artistName == LartistName) {
                    return MyexpensiontileArtist(
                      atistimage: artworkSnapshot.data,
                      artistName: artistName,
                      songNum: artistNamesongnum.length,
                      albumNum: albums.length,
                      albumName: albums,
                    );
                  }
                  return SizedBox.shrink();
                },
              );
            },
          );
        }
      }),
    );
  }
}
