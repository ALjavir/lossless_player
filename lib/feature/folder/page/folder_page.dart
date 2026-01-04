import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/feature/folder/widget/myexpensiontile_folder.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Folder extends StatefulWidget {
  const Folder({super.key});

  @override
  State<Folder> createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  final PlayerController controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.selectedFolders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No song found!", style: TextStyle(fontSize: 20)),
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
          final myfolder = controller.folderSong;
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: myfolder.length,
              itemBuilder: (context, index) {
                String folderName = controller.folderSong.keys.elementAt(index);
                List<SongModel> folderSong = controller.folderSong.values
                    .elementAt(index);
                int picID = controller.folderNpic.values.elementAt(index);

                //List<String> folders = controller.folderSong[folderName] ?? [];
                //print("//////////////////////////////////////Folder Page");
                //print(folderName);
                return FutureBuilder<Uint8List?>(
                  future: controller.audioQuery.queryArtwork(
                    picID,
                    ArtworkType.AUDIO,
                    format: ArtworkFormat.JPEG,
                    quality: 1000,
                  ),
                  builder: (context, artworkSnapshot) {
                    return MyexpensiontileFolder(
                      folderName: folderName,
                      folderSong: folderSong,
                      folderImage: artworkSnapshot.data,
                    );
                  },
                );
                // MyexpensiontileFolder(
                //   folderName: folderName,
                //   folderSong: folderSong,
                //   folderImage: null,
                // );
              },
            ),
          );
        }
      }),
    );
  }
}
