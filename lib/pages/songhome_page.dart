import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lossless_audio/controller/player_controller.dart';
import 'package:lossless_audio/style/font.dart';
import 'package:lossless_audio/widget/mystgriedview_song.dart';
import 'package:lossless_audio/widget/song_contaner.dart';

class SongHomePage extends StatefulWidget {
  const SongHomePage({super.key});

  @override
  State<SongHomePage> createState() => _SongHomePageState();
}

class _SongHomePageState extends State<SongHomePage> {
  final PlayerController controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (controller.selectedFolders.isEmpty) {
            //print(
            //"-----------------------------------this is Part: 1--------------------------------");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white70,
                  title: Text(
                    'Permission',
                    style: TextStyle(fontSize: 30),
                  ),
                  content: Text(
                    'Please select an audio folder.',
                    style: TextStyle(fontSize: 20),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text(
                        "Cancel",
                        style: Fontstyle.songN(25, Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String? folderPath =
                            await FilePicker.platform.getDirectoryPath();
                        if (folderPath != null) {
                          controller.addFolder(folderPath);
                          Navigator.pop(
                              context); // Close the dialog after selecting a folder
                        }
                      },
                      child: Text(
                        "Select Folder",
                        style: Fontstyle.songN(25, Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            });

            return SizedBox.shrink();
          } else {
            //print("-----------------------------------this is Part: 2---------------------------------");
            // Use cached songs from the controller
            final songs = controller.cachedSongs;

            if (songs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      "No songs found!",
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        controller.showdiolog(context);
                        Navigator.pop(
                            context); // Close the dialog after selecting a folder
                      },
                      child: Text(
                        "Select Folder",
                        style: Fontstyle.songN(25, Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  MystgriedviewSong(),
                  Text(
                    "Songs",
                    style: Fontstyle.thambalfont(30, Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SongContaner(
                      buildCondition: 'full',
                    ),
                  )
                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: songs.length,
                  //   separatorBuilder: (context, index) => const Divider(),
                  //   itemBuilder: (context, index) {
                  //     final song = songs[index];
                  //     return FutureBuilder<Uint8List?>(
                  //       future: controller.audioQuery.queryArtwork(
                  //           song.id, ArtworkType.AUDIO,
                  //           format: ArtworkFormat.JPEG, quality: 1000),
                  //       builder: (context, artworkSnapshot) {
                  //         final artwork = artworkSnapshot.data;
                  //         final duration =
                  //             controller.formatDuration(song.duration!.toInt());
                  //         return SongContaner(
                  //             coverImage: artwork,
                  //             name: song.title,
                  //             artist: song.artist ?? "Unknown Artist",
                  //             albam: song.album ?? "Unknown Album",
                  //             formate: song.fileExtension,
                  //             endtime: duration);
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
          }
        }));
  }
}
