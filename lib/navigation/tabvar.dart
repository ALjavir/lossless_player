import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_player/controller/player_controller.dart';
import 'package:lossless_player/feature/artist/page/artist_page.dart';
import 'package:lossless_player/feature/folder/page/folder_page.dart';
import 'package:lossless_player/feature/home/page/songhome_page.dart';
import 'package:lossless_player/style/font.dart';

class Tabvar extends StatefulWidget {
  const Tabvar({super.key});

  @override
  State<Tabvar> createState() => _TabvarState();
}

class _TabvarState extends State<Tabvar> {
  final PlayerController controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          //toolbarHeight: 80,
          //bottomOpacity: 0.5,
          backgroundColor: Colors.white,

          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Image.asset("lib/assets/icon/logo.png", scale: 4),
              Text(
                "Lossless Music",
                style: Fontstyle.appbarfont(26, Colors.black),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.showdiolog(context);
              },
              icon: Icon(Icons.folder),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            //   padding: EdgeInsetsGeometry.only(bottom: 10),
            tabAlignment: TabAlignment.center,
            unselectedLabelColor: Colors.black26,
            labelColor: Colors.black,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,

            tabs: [
              Tab(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.music_note),
                    SizedBox(width: 6),
                    Text(
                      "Song.",
                      style: Fontstyle.thambalfont(18, FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 6),
                    Text(
                      "Artist.",
                      style: Fontstyle.thambalfont(18, FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.folder),
                    SizedBox(width: 6),
                    Text(
                      "Folder.",
                      style: Fontstyle.thambalfont(18, FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SongHomePage(), // Added Homepage here
            ArtistPage(),
            Folder(),
            // Genres(),
            //Test()
          ],
        ),
      ),
    );
  }

  Future<void> showdiolog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Folder'),
          content: Obx(() {
            // Wrap ListView.builder in Obx to update when RxList changes
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.selectedFolders.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(controller.selectedFolders[index]));
              },
            );
          }),
          actions: [
            FloatingActionButton.small(
              onPressed: () async {
                // Let user pick a folder and add it to the list
                String? folderPath = await FilePicker.getDirectoryPath();
                if (folderPath != null) {
                  controller.addFolder(folderPath);
                  Navigator.pop(context); // Add folder via controller
                }
              },
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ],
        );
      },
    );
  }
}
