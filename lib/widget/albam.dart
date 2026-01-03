import 'package:flutter/material.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/widget/song_contaner.dart';

class Albam extends StatefulWidget {
  final List<String> albamName;
  final String artistName;

  const Albam({super.key, required this.albamName, required this.artistName});

  @override
  State<Albam> createState() => _AlbamState();
}

class _AlbamState extends State<Albam> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.albamName.length,
      separatorBuilder: (context, index) => const Divider(
        //color: Colors.deepPurple,
      ),
      itemBuilder: (context, index) {
        //'assets/icon/1.jpg'
        return ExpansionTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent), // Removes border
          ),
          minTileHeight: 0,
          tilePadding: EdgeInsets.fromLTRB(8, 0, 0, 4),
          title: Text(
            widget.albamName[index],
            style: Fontstyle.AlbamN(16, FontWeight.bold),
          ),
          children: [
            SongContaner(
              buildCondition: widget.albamName[index],
              buildCondition1: widget.artistName,
            ),
            //print(widget.albamName[index]);
            // ListView.builder(
            //     shrinkWrap: true,
            //     physics: ScrollPhysics(),
            //     itemCount: widget.albamName.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return
            //       SongContaner(
            //         buildCondition: albamName,
            //         );
            //     }),
          ],
        );
      },
    );
  }
}
