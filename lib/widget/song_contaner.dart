import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_audio/controller/player_controller.dart';
import 'package:lossless_audio/pages/audioPlayer_page.dart';
import 'package:lossless_audio/style/font.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongContaner extends StatefulWidget {
  //final int numberOfSong;
  final String buildCondition;
  final String? buildCondition1;
  //final List<SongModel> songs;

  const SongContaner({
    super.key,
    //required this.numberOfSong,
    required this.buildCondition,
    this.buildCondition1,
    //required this.songs
  });

  @override
  State<SongContaner> createState() => _SongContanerState();
}

//Color hificolor = Colors.black;
//Color nonhificolor = Colors.black45;

class _SongContanerState extends State<SongContaner> {
  final PlayerController controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    //
    RxList<SongModel> songs = <SongModel>[].obs;
    Color dividerColor;
    if (widget.buildCondition == "full") {
      songs = controller.cachedSongs;
      dividerColor = Colors.black26;
    } else {
      final albumNsong = controller.albumNsong;
      // final artistNsong = controller.artistNsongnumber;
      final y = controller.folderSong;
      dividerColor = Colors.white;
      if (albumNsong.containsKey(widget.buildCondition)) {
        for (var a in albumNsong.values) {
          for (var x in a) {
            songs.addIf(
                x.artist == widget.buildCondition1 &&
                    x.album == widget.buildCondition,
                x);
          }
        }
        //songs = albumNsong[widget.buildCondition]!;
        print(
            "This is x--------------------------------------------------------:$songs ");
      }
      if (y.containsKey(widget.buildCondition)) {
        songs = y[widget.buildCondition]!;
        print(
            "This is y--------------------------------------------------------:$songs ");
      }
    }
    //final songs = controller.cachedSongs;
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: songs.length,
        separatorBuilder: (context, index) => Divider(
              color: dividerColor,
            ),
        itemBuilder: (context, index) {
          final song = songs[index];
          //print('$song.artist\n');
          return FutureBuilder<Uint8List?>(
              future: controller.audioQuery.queryArtwork(
                  song.id, ArtworkType.AUDIO,
                  format: ArtworkFormat.JPEG, quality: 1000),
              builder: (context, artworkSnapshot) {
                if (artworkSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final artwork = artworkSnapshot.data;
                final duration =
                    controller.formatDuration(song.duration!.toInt());
                final Color badgeColor =
                    ["mp3", "aac"].contains(song.fileExtension.toLowerCase())
                        ? Colors.white70
                        : Colors.transparent;

                return InkWell(
                  onTap: () =>
                      Get.to(() => AudioplayerPage(songPath: song.data)),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(0),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35,
                          backgroundImage:
                              artwork != null ? MemoryImage(artwork) : null,
                          child: artwork == null
                              ? Icon(
                                  Icons.music_note,
                                  size: 40,
                                  color: Colors.black,
                                )
                              : null,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.title,
                                  style: Fontstyle.songN(16, Colors.black),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                Text(
                                  song.album!,
                                  // song.artist != '<unknown>'
                                  //     ? song.album!
                                  //     : 'Unknown Album',
                                  style:
                                      Fontstyle.AlbamN(12, FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                Text(
                                  //song.artist ?? 'Unknown Artist',
                                  song.artist!,
                                  // = '<unknown>'
                                  //     ? song.artist!
                                  //     : "Unknown Artist",
                                  style: Fontstyle.artistN(12),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      duration,
                                      style: Fontstyle.AlbamN(
                                          12, FontWeight.normal),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                    Text(
                                      " / ${song.fileExtension}",
                                      style: Fontstyle.thambalfont(
                                          12, Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        //Expanded(child: Container()),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            IconButton(
                                visualDensity: VisualDensity.compact,
                                alignment: Alignment.topCenter,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                )),
                            Container(
                              foregroundDecoration:
                                  BoxDecoration(color: badgeColor),
                              child: Image.asset(
                                  scale: 35, "assets/icon/hi-res_logo.jpg"),
                            ),
                            // Row(
                            //   spacing: 5.0,
                            //   children: [
                            //     // Text(
                            //     //   song.fileExtension,
                            //     //   style: Fontstyle.thambalfont(14, Colors.black),
                            //     // ),
                            //     Container(
                            //       width: 40,
                            //       decoration: BoxDecoration(
                            //           color: badgeColor,
                            //           borderRadius:
                            //               BorderRadius.all(Radius.circular(10))),
                            //       child:
                            //        Text(
                            //         "HI-FI",
                            //         textAlign: TextAlign.center,
                            //         style:
                            //             Fontstyle.thambalfont(14, Colors.white),
                            //       ),
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
