import 'package:flutter/material.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/feature/global/song_contaner.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.albamName.length,

      itemBuilder: (context, index) {
        return ExpansionTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          minTileHeight: 0,
          tilePadding: EdgeInsets.zero,
          title: Text(
            widget.albamName[index],
            style: Fontstyle.AlbamN(16, FontWeight.bold),
          ),
          children: [
            SongContaner(
              buildCondition: widget.albamName[index],
              buildCondition1: widget.artistName,
            ),
          ],
        );
      },
    );
  }
}
