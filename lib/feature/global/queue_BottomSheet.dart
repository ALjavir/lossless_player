import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/state_manager.dart';
import 'package:lossless_player/feature/global/audioPlayer_page.dart';
import 'package:lossless_player/style/font.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueBottomSheet extends StatefulWidget {
  final RxList<SongModel> songs;
  final RxInt currentIndex;

  const QueueBottomSheet({
    super.key,
    required this.songs,
    required this.currentIndex,
  });

  @override
  State<QueueBottomSheet> createState() => _QueueBottomSheetState();
}

class _QueueBottomSheetState extends State<QueueBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final songList = widget.songs;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          const SizedBox(height: 10),

          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Up Next",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = widget.songs[index];

                final isCurrent = index == widget.currentIndex;

                return InkWell(
                  onTap: () {
                    Get.back();

                    Get.to(
                      () => AudioplayerPage(
                        songs: widget.songs,
                        initialIndex: index,
                      ),
                      transition: Transition.downToUp,
                    );
                  },
                  child: ListTile(
                    selected: isCurrent,
                    selectedTileColor: Colors.black12,

                    leading: isCurrent
                        ? const Icon(Icons.graphic_eq, color: Colors.green)
                        : Text(
                            "${index + 1}",
                            style: Fontstyle.navfont(
                              22,
                              //FontWeight.bold,
                              Colors.white,
                            ),
                          ),

                    title: Text(
                      song.title.capitalizeFirst!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Fontstyle.songN(
                        16,
                        isCurrent ? Colors.green : Colors.white,
                        FontWeight.w500,
                      ),
                    ),

                    subtitle: Text(
                      song.artist ?? "Unknown Artist",
                      style: Fontstyle.AlbamN(
                        16,
                        FontWeight.w500,
                        Colors.white54,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
