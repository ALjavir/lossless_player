import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/feature/global/song_contaner.dart';
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
  RxBool isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    final artwork = widget.folderImage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: Colors.white,
              margin: EdgeInsets.zero,
              child: artwork != null
                  ? Image.memory(
                      artwork,
                      fit: BoxFit.fitHeight,
                      width: 150,
                      height: 150,
                    )
                  : SizedBox(
                      width: 150,
                      height: 150,
                      child: Center(
                        child: Icon(
                          Icons.music_note,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),

            ///expriment
            Expanded(
              child: Text(
                widget.folderName,
                style: Fontstyle.artistN(18, FontWeight.normal, Colors.black),
                overflow: TextOverflow.fade,
                maxLines: 5,
              ),
            ),
          ],
        ),

        Card(
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          color: Colors.white,
          margin: EdgeInsets.zero,
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            backgroundColor: Colors.white,
            iconColor: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent), // Removes border
            ),
            minTileHeight: 0,
            childrenPadding: EdgeInsets.symmetric(horizontal: 4),

            title: Text(
              "Song: ${widget.folderSong.length}",
              style: Fontstyle.AlbamN(18, FontWeight.normal, Colors.black),
            ),
            children: [
              SongContaner(buildCondition: widget.folderName),
              //  Divider(color: Colors.black12),
            ],
          ),
        ),
        Divider(color: Colors.transparent),
      ],
    );
  }
}
