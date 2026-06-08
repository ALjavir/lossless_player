import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lossless_player/style/font.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueBottomSheet extends StatelessWidget {
  final List<SongModel> songs;
  final int currentIndex;

  const QueueBottomSheet({
    super.key,
    required this.songs,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          const SizedBox(height: 10),

          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
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
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];

                final isCurrent = index == currentIndex;

                return ListTile(
                  selected: isCurrent,
                  selectedTileColor: Colors.white10,

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
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isCurrent ? Colors.green : Colors.white,
                    ),
                  ),

                  subtitle: Text(
                    song.artist ?? "Unknown Artist",
                    style: const TextStyle(color: Colors.white54),
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
