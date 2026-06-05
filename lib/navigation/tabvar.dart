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
              Text("Lossless Music", style: Fontstyle.appbarfont(26)),
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
                    Icon(Icons.album),
                    SizedBox(width: 6),
                    Text("Song.", style: Fontstyle.navfont(18)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 6),
                    Text("Artist.", style: Fontstyle.navfont(18)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.folder),
                    SizedBox(width: 6),
                    Text("Folder.", style: Fontstyle.navfont(18)),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SongHomePage(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ArtistPage(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Folder(),
            ),
            // Genres(),
            //Test()
          ],
        ),
      ),
    );
  }
}
