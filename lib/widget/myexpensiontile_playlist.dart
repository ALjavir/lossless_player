import 'package:flutter/material.dart';
import 'package:lossless_player/style/font.dart';

// import 'package:music_player/style/font.dart';
// import 'package:music_player/widget/song_contaner.dart';

class MyexpensiontilePlaylist extends StatefulWidget {
  const MyexpensiontilePlaylist({super.key});

  @override
  State<MyexpensiontilePlaylist> createState() =>
      _MyexpensiontilePlaylistState();
}

class _MyexpensiontilePlaylistState extends State<MyexpensiontilePlaylist> {
  X x = X();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icon/1.jpg'),
              fit: BoxFit.cover,

              // colorFilter: ColorFilter.matrix(<double>[
              //   0.2126,
              //   0.7152,
              //   0.0722,
              //   0,
              //   0,
              //   0.2126,
              //   0.7152,
              //   0.0722,
              //   0,
              //   0,
              //   0.2126,
              //   0.7152,
              //   0.0722,
              //   0,
              //   0,
              //   0,
              //   0,
              //   0,
              //   1,
              //   0,
              // ])
            ),
          ),
          child: Center(
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black), // Removes border
              ),
              child: Text(
                " Rock n Roll ",
                style: Fontstyle.thambalfont(35, Colors.white),
              ),
            ),
          ),
        ),
        ExpansionTile(
          backgroundColor: const Color.fromARGB(
            255,
            255,
            255,
            255,
          ).withOpacity(0.2),
          iconColor: const Color.fromARGB(255, 0, 0, 0),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent), // Removes border
          ),
          minTileHeight: 0,
          childrenPadding: EdgeInsets.all(8),

          onExpansionChanged: (value) {
            setState(() {
              x.expend = value; // Use the passed 'X' instance
            });
            print("Expanded state: ${x.expend}");
            x.printex();
          },

          // leading: CircleAvatar(
          //     radius: 30,
          //     backgroundImage: AssetImage(
          //       'assets/icon/T.png',
          //     )),
          //tilePadding: EdgeInsets.all(0),
          title: Text("Song: 12", style: Fontstyle.songN(18, Colors.black)),

          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 25,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return Text("data");
              },
            ),
          ],
        ),
      ],
    );
  }
}
