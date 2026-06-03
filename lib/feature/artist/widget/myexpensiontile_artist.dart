import 'dart:typed_data';
import 'dart:ui';

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
  bool isExpanded = false;

  //get albumName => albumName;

  @override
  Widget build(BuildContext context) {
    final artwork = widget.atistimage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentGeometry.bottomRight,
          children: [
            // ClipRRect(
            //   child: ImageFiltered(
            //     imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            //     child: artwork != null
            //         ? Image.memory(
            //             artwork,
            //             fit: BoxFit.cover,
            //             width: double.maxFinite,
            //             height: 150,
            //           )
            //         : Center(
            //             child: Icon(
            //               Icons.music_note,
            //               size: 40,
            //               color: Colors.black,
            //             ),
            //           ),
            //   ),
            // ),
            Row(
              spacing: 10,
              children: [
                artwork != null
                    ? Image.memory(
                        artwork,
                        fit: BoxFit.fitHeight,
                        width: 150,
                        height: 150,
                      )
                    : Center(
                        child: Icon(
                          Icons.music_note,
                          size: 40,
                          color: Colors.black,
                        ),
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
            IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                size: 30,
              ),
            ),
          ],
        ),

        // Stack(
        //   children: [
        //     ClipRRect(
        //       child: ImageFiltered(
        //         imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        //         child: artwork != null
        //             ? Image.memory(
        //                 artwork,
        //                 fit: BoxFit.cover,
        //                 width: double.maxFinite,
        //                 height: 150,
        //               )
        //             : Center(
        //                 child: Icon(
        //                   Icons.music_note,
        //                   size: 40,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //       ),
        //     ),
        //   ],
        // ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Albam(
                  albamName: widget.albumName,
                  artistName: widget.artistName,
                )
              : const SizedBox.shrink(),
        ),
        SizedBox(child: Divider(color: Colors.black26)),
      ],
    );
  }
}
