import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_audio/controller/player_controller.dart';
import 'package:lossless_audio/style/font.dart';
import 'package:lossless_audio/widget/myexpensiontile_artist.dart';
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
                  Text(
                    "No Artist found!",
                    style: TextStyle(fontSize: 20),
                  ),
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
                String LartistName =
                    controller.artisNalbum.keys.elementAt(index);
                List<String> albums = controller.artisNalbum[artistName] ?? [];
                List<String> artistNamesongnum =
                    controller.artistNsongnumber.values.elementAt(index);
                return FutureBuilder<Uint8List?>(
                    future: controller.audioQuery.queryArtwork(
                        picID, ArtworkType.AUDIO,
                        format: ArtworkFormat.JPEG, quality: 1000),
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
                    });
              },
            );

            //   return ListView.builder(
            //     itemCount: controller.artistNpic.length,
            //     itemBuilder: (context, index) {
            //       return FutureBuilder<Uint8List?>(
            //           future: controller.audioQuery.queryArtwork(
            //               snapshot.data![index].id, ArtworkType.AUDIO,
            //               format: ArtworkFormat.JPEG, quality: 1000),
            //           builder: (context, artworkSnapshot) {
            //             final artistName = uniqueArtists[index];
            //             print(
            //                 '$index:---------------------------------------- $artistName');
            //             // ✅ Find all songs by this artist
            //             final artistSongs = snapshot.data!
            //                 .where((song) => song.artist == artistName)
            //                 .toList();
            //             final totalSongs = artistSongs.length;

            //             // ✅ Find total unique albums by this artist
            //             final totalAlbums = artistSongs
            //                 .map(
            //                   (song) => song.artist != '<unknown>'
            //                       ? song.album!
            //                       : 'Unknown Album',
            //                 )
            //                 .toSet()
            //                 .length;
            //             //print('$index:--------------------------------------------$[index]\n');
            //             return MyexpensiontileArtist(
            //               atistimage: artworkSnapshot.data,
            //               artistName: artistName,
            //               songNum: totalSongs,
            //               albumNum: totalAlbums,
            //               //albumName: snapshot.data![index].album!,
            //               albumName: "",
            //             );
            //           });
            //     },
            //   );
            // }}));
            // controller.artistName.clear();
            // for (var song in controller.cachedSongs) {
            //   if (song.artist != null) {
            //     controller.artistName.add(song.artist!);
            //   }
            // }

            // final ArtisInfo = controller.Album;

            // return ListView.builder(
            //     itemCount: ArtisInfo.length,
            //     itemBuilder: (context, index) {
            //       //final uniqueArtistNames = uniqueArtis[index];

            //       return FutureBuilder<Uint8List?>(
            //         future: controller.audioQuery.queryArtwork(
            //           controller.Artist[index].id,
            //           ArtworkType.AUDIO,
            //           format: ArtworkFormat.JPEG,
            //           quality: 1000,
            //         ),
            //         builder: (context, artworkSnapshot) {
            //           if (artworkSnapshot.connectionState ==
            //               ConnectionState.waiting) {
            //             return CircularProgressIndicator();
            //           }
            //           final artwork = artworkSnapshot.data;

            //           return MyexpensiontileArtist(
            //             artistName: uniqueArtis[index],
            //             atistimage: artwork,
            //           );
            //         },
            //       );
            //       //return SizedBox.shrink();
            //     });
          }
        }));
  }
}
