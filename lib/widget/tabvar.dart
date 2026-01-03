import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_audio/controller/player_controller.dart';
import 'package:lossless_audio/pages/artist_page.dart';
import 'package:lossless_audio/pages/folder_page.dart';
import 'package:lossless_audio/pages/genres_page.dart';
import 'package:lossless_audio/pages/songhome_page.dart';
import 'package:lossless_audio/style/font.dart';

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
          //toolbarHeight: 80,
          //bottomOpacity: 0.5,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Image.asset(
              "assets/icon/logo.png",
            ),
          ),
          title: Text("Lossless Music",
              style: Fontstyle.appbarfont(26, Colors.black)),
          actions: [
            IconButton(
              onPressed: () {
                controller.showdiolog(context);
              },
              icon: Icon(Icons.folder),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            //padding: EdgeInsets.only(left: 8),
            tabAlignment: TabAlignment.center,
            unselectedLabelColor: Colors.black26,
            labelColor: Colors.black,
            indicatorColor: const Color.fromARGB(255, 0, 0, 0),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.circle_rounded),
                    SizedBox(
                      width: 6,
                    ),
                    Text("Song", style: Fontstyle.thambalfont(12, Colors.black))
                  ],
                ),
              ),
              Tab(
                  child: Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(
                    width: 6,
                  ),
                  Text("Artist", style: Fontstyle.thambalfont(12, Colors.black))
                ],
              )),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.folder),
                    SizedBox(
                      width: 6,
                    ),
                    Text("Folder",
                        style: Fontstyle.thambalfont(12, Colors.black))
                  ],
                ),
              ),
              Tab(
                  child: Row(
                children: [
                  Icon(Icons.style_rounded),
                  SizedBox(
                    width: 6,
                  ),
                  Text("Genres", style: Fontstyle.thambalfont(12, Colors.black))
                ],
              )),

              // Tab(
              //   child: Row(
              //     children: [
              //       Icon(Icons.circle_rounded),
              //       SizedBox(
              //         width: 6,
              //       ),
              //       Text("Song", style: Fontstyle.poiretOne())
              //     ],
              //   ),
              // ),
              // Tab(
              //   child: Row(
              //     children: [
              //       Icon(Icons.circle_rounded),
              //       SizedBox(
              //         width: 6,
              //       ),
              //       Text("Song", style: Fontstyle.poiretOne())
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SongHomePage(), // Added Homepage here
            ArtistPage(),
            Folder(),
            Genres(),
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
                return ListTile(
                  title: Text(controller.selectedFolders[index]),
                );
              },
            );
          }),
          actions: [
            FloatingActionButton.small(
              onPressed: () async {
                // Let user pick a folder and add it to the list
                String? folderPath =
                    await FilePicker.platform.getDirectoryPath();
                if (folderPath != null) {
                  controller.addFolder(folderPath);
                  Navigator.pop(context); // Add folder via controller
                }
              },
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
