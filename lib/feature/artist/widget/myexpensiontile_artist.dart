import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/feature/artist/widget/albam.dart';

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

  int get songNum => widget.songNum;
  RxBool isExpanded = false.obs;

  //get albumName => albumName;

  @override
  Widget build(BuildContext context) {
    final artwork = widget.atistimage;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentGeometry.bottomRight,
            children: [
              Row(
                spacing: 10,
                children: [
                  Card(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.artistName.toUpperCase(),
                          style: Fontstyle.artistN(
                            18,
                            FontWeight.normal,
                            Colors.black,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                        Text(
                          'Album: ${widget.albumNum} / Song: ${widget.songNum}',
                          style: Fontstyle.AlbamN(
                            14,
                            FontWeight.normal,
                            Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  isExpanded.value = !isExpanded.value;
                },
                icon: Icon(
                  isExpanded.value
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  size: 30,
                ),
              ),
            ],
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: isExpanded.value
                ? Albam(
                    albamName: widget.albumName,
                    artistName: widget.artistName,
                  )
                : const SizedBox.shrink(),
          ),
          SizedBox(child: Divider(color: Colors.transparent)),
        ],
      ),
    );
  }
}
