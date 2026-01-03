import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lossless_audio/controller/player_controller.dart';
import 'package:lossless_audio/style/font.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MystgriedviewSong extends StatefulWidget {
  const MystgriedviewSong({
    super.key,
  });

  @override
  State<MystgriedviewSong> createState() => _MystgriedviewState();
}

class _MystgriedviewState extends State<MystgriedviewSong> {
  final PlayerController controller = Get.put(PlayerController());
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        _scrollPosition += 60; // Adjust speed (higher = faster)

        // If reached the end, reset to start
        if (_scrollController.position.maxScrollExtent <= _scrollPosition) {
          _scrollPosition = 0;
          _scrollController.jumpTo(_scrollPosition);
        } else {
          _scrollController.animateTo(
            _scrollPosition,
            duration: Duration(milliseconds: 0),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songs = controller.cachedSongs;
    if (songs.isEmpty) {
      return Center(
        child: Text("No songs found!"),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(3, 0, 3, 6),
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
          childrenDelegate: SliverChildBuilderDelegate(childCount: songs.length,
              (context, index) {
            final song = songs[index];

            return FutureBuilder<Uint8List?>(
              future: controller.audioQuery.queryArtwork(
                  song.id, ArtworkType.AUDIO,
                  format: ArtworkFormat.PNG, size: 1000),
              builder: (context, artworkSnapshot) {
                final artwork = artworkSnapshot.data;
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(2),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: artwork != null
                            ? Image.memory(
                                artwork,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.music_note,
                                size: 40,
                                color: Colors.black,
                              ),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadiusDirectional.vertical(
                                  bottom: Radius.circular(10))),
                          width: double.maxFinite,
                          child: Text(
                            song.title,
                            style: Fontstyle.songN(18, Colors.white),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                );
              },
            );
          }),
        ),
      );
    }
  }
}
