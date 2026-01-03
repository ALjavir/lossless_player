import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/widget/song_contaner.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyexpensiontileFolder extends StatefulWidget {
  final String folderName;
  final List<SongModel> folderSong;
  final Uint8List? folderImage;
  const MyexpensiontileFolder({
    super.key,
    required this.folderName,
    required this.folderSong,
    required this.folderImage,
  });

  @override
  State<MyexpensiontileFolder> createState() => _MyexpensiontileFolderState();
}

class _MyexpensiontileFolderState extends State<MyexpensiontileFolder> {
  final PlayerController controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: widget.folderImage != null
                      ? MemoryImage(widget.folderImage!)
                      : null,
                  child: widget.folderImage == null
                      ? Icon(Icons.music_note, size: 40, color: Colors.black)
                      : null,
                ),

                ///expriment
                Expanded(
                  child: Text(
                    widget.folderName,
                    style: Fontstyle.artistN(18),
                    overflow: TextOverflow.fade,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.only(left: 0),
              backgroundColor: const Color.fromARGB(
                255,
                255,
                255,
                255,
              ).withOpacity(0.2),
              iconColor: const Color.fromARGB(255, 0, 0, 0),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent), // Removes border
              ),
              minTileHeight: 0,
              childrenPadding: EdgeInsets.all(0),
              title: Text(
                "Song: ${widget.folderSong.length}",
                style: Fontstyle.songN(18, Colors.black),
              ),
              children: [SongContaner(buildCondition: widget.folderName)],
            ),
          ],
        ),
      ),
    );
  }
}
