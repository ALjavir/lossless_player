import 'package:flutter/material.dart';
import 'package:lossless_player/feature/songs/model/song_model.dart';
import 'package:lossless_player/style/font.dart';

class SongView extends StatefulWidget {
  final SongModel songModel;
  const SongView({super.key, required this.songModel});

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  @override
  Widget build(BuildContext context) {
    final song = widget.songModel;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(0),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            backgroundImage: song.artwork != null
                ? MemoryImage(song.artwork!)
                : null,
            child: song.artwork == null
                ? Icon(Icons.music_note, size: 40, color: Colors.black)
                : null,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.displayName,
                    style: Fontstyle.songN(16, Colors.black),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  Text(
                    song.album,

                    style: Fontstyle.AlbamN(12, FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  Text(
                    song.artist,

                    style: Fontstyle.artistN(12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  Row(
                    children: [
                      Text(
                        song.duration.toString(),
                        style: Fontstyle.AlbamN(12, FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Text(
                        " / ${song.fileExtention}",
                        style: Fontstyle.thambalfont(12, Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                alignment: Alignment.topCenter,
                onPressed: () {},
                icon: Icon(Icons.add_circle, color: Colors.black),
              ),
              Container(
                foregroundDecoration: BoxDecoration(color: badgeColor),
                child: Image.asset(scale: 35, "assets/icon/hi-res_logo.jpg"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
