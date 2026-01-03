import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/widget/albam.dart';

// import 'package:music_player/style/font.dart';
// import 'package:music_player/widget/albam.dart';

class MyexpensiontileArtist extends StatefulWidget {
  final Uint8List? atistimage;
  final String artistName;
  final int songNum;
  final int albumNum;
  final List<String> albumName;
  const MyexpensiontileArtist({
    super.key,
    required this.atistimage,
    required this.artistName,
    required this.songNum,
    required this.albumNum,
    required this.albumName,
  });

  @override
  State<MyexpensiontileArtist> createState() => _MyExpensionTileState();
}

class _MyExpensionTileState extends State<MyexpensiontileArtist> {
  final PlayerController controller = Get.put(PlayerController());

  //get albumNumm => widget.albumNum;

  get songNum => widget.songNum;

  //get albumName => albumName;

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
                  backgroundImage: widget.atistimage != null
                      ? MemoryImage(widget.atistimage!)
                      : null,
                  child: widget.atistimage == null
                      ? Icon(Icons.music_note, size: 40, color: Colors.black)
                      : null,
                ),

                ///expriment
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.artistName,
                        style: Fontstyle.artistN(18),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                      Text(
                        'Album: ${widget.albumNum} / Song: ${widget.songNum}',
                        style: Fontstyle.AlbamN(14, FontWeight.bold),
                      ),
                    ],
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
                "This is 🎵${widget.artistName}",
                style: Fontstyle.artistN(18),
              ),
              children: [
                Albam(
                  albamName: widget.albumName,
                  artistName: widget.artistName,
                  //albumNum: widget.albumNum,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
