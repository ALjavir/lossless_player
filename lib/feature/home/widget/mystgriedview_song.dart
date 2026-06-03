import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/feature/global/audioPlayer_page.dart';

import 'package:lossless_player/style/font.dart';

import 'package:on_audio_query/on_audio_query.dart';

class MystgriedviewSong extends StatefulWidget {
  const MystgriedviewSong({super.key});

  @override
  State<MystgriedviewSong> createState() => _MystgriedviewState();
}

class _MystgriedviewState extends State<MystgriedviewSong> {
  final PlayerController controller = Get.put(PlayerController());

  RxList<SongModel> songs = <SongModel>[].obs;
  @override
  void initState() {
    super.initState();

    songs.value = List<SongModel>.from(controller.cachedSongs);
  }

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return Center(child: Text("No songs found!"));
    } else {
      return Stack(
        //crossAxisAlignment: CrossAxisAlignment.end,
        alignment: AlignmentDirectional.center,
        children: [
          Obx(
            () => SizedBox(
              height: 350,
              width: double.maxFinite,
              child: GridView.custom(
                //controller: _scrollController,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 2,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: songs.length,
                  (context, index) {
                    final song = songs[index];

                    return FutureBuilder<Uint8List?>(
                      future: controller.audioQuery.queryArtwork(
                        song.id,
                        ArtworkType.AUDIO,
                        format: ArtworkFormat.PNG,
                        size: 1000,
                      ),
                      builder: (context, artworkSnapshot) {
                        final artwork = artworkSnapshot.data;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 8),
                          child: InkWell(
                            onTap: () {
                              List<SongModel> currentPlaylist =
                                  controller.cachedSongs;

                              // 2. Navigate
                              Get.to(
                                () => AudioplayerPage(
                                  songs: currentPlaylist,
                                  initialIndex: index,
                                ),
                                transition: Transition.downToUp,
                              );
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                artwork != null
                                    ? Image.memory(artwork, fit: BoxFit.cover)
                                    : Center(
                                        child: Icon(
                                          Icons.music_note,
                                          size: 40,
                                          color: Colors.black,
                                        ),
                                      ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                  ),
                                  width: double.maxFinite,
                                  child: Text(
                                    song.title.capitalizeFirst!,
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style: Fontstyle.songN(18, Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.shuffle_outlined,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  songs.shuffle();
                },
              ),
            ),
          ),
        ],
      );
    }
  }
}
