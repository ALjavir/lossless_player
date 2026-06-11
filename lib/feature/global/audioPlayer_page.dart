import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lossless_player/feature/global/queue_BottomSheet.dart';
import 'package:lossless_player/style/font.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioplayerPage extends StatefulWidget {
  // Change: Accept the whole list and the starting index
  final List<SongModel> songs;
  final int initialIndex;

  const AudioplayerPage({
    super.key,
    required this.songs,
    required this.initialIndex,
  });

  @override
  State<AudioplayerPage> createState() => _AudioplayerPageState();
}

class _AudioplayerPageState extends State<AudioplayerPage> {
  late AudioPlayer _audioPlayer;
  late RxInt _currentIndex;
  RxBool _isPlaying = false.obs;
  RxBool _isShuffle = false.obs;
  LoopMode _loopMode = LoopMode.off;
  @override
  void initState() {
    super.initState();

    print("AudioplayerPage created: ${widget.initialIndex}");
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.initialIndex.obs;

    _loadSong();

    // Listen to player state for UI updates
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        _isPlaying.value = state.playing;
      }
      // Auto-play next song when current finishes
      if (state.processingState == ProcessingState.completed) {
        _playNext();
      }
    });
  }

  Future<void> _loadSong() async {
    try {
      await _audioPlayer.setFilePath(widget.songs[_currentIndex.value].data);
      _audioPlayer.play();
      print(
        "This is from inside widegt _loadSong: ${widget.songs[_currentIndex.value].title}---------------------------------------------------------------------------------------------------",
      );
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void _playPrevious() {
    if (_currentIndex.value > 0) {
      _currentIndex.value--;

      _loadSong();
    }
    print(
      "This is from inside widegt _playPrevious: ${widget.songs[_currentIndex.value].title}---------------------------------------------------------------------------------------------------",
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Helper to format time (e.g., 1:06)
  String _formatDuration(Duration? duration) {
    if (duration == null) return "0:00";
    String minutes = duration.inMinutes.toString();
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _playNext() {
    if (_loopMode == LoopMode.one) {
      // If Repeat One is on, just replay the current song
      _audioPlayer.seek(Duration.zero);
      _audioPlayer.play();
    } else if (_isShuffle.value) {
      // If Shuffle is on, pick a random song

      _currentIndex.value = Random().nextInt(widget.songs.length);

      _loadSong();
    } else {
      // Normal Logic
      if (_currentIndex.value < widget.songs.length - 1) {
        _currentIndex.value++;

        _loadSong();
      } else if (_loopMode == LoopMode.all) {
        // If at the end AND Repeat All is on, go back to start

        _currentIndex.value = 0;

        _loadSong();
      }
    }
    print(
      "This is from inside widegt _playNext: ${widget.songs[_currentIndex.value].title}---------------------------------------------------------------------------------------------------",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Obx(() {
        final currentSong = widget.songs[_currentIndex.value];
        final Color badgeColor =
            ["mp3", "aac"].contains(currentSong.fileExtension.toLowerCase())
            ? Colors.white70
            : Colors.transparent;

        final text = currentSong.title;

        final textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: Fontstyle.artistN(28, FontWeight.w600, Colors.white),
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout();
        final availableWidth = MediaQuery.of(context).size.width - 40;
        final isOverflowing = textPainter.width > availableWidth;

        print(
          "This is from inside widegt build: ${currentSong.title}---------------------------------------------------------------------------------------------------",
        );

        return Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: ClipRRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: QueryArtworkWidget(
                    id: currentSong.id,
                    artworkBorder: BorderRadius.zero,
                    type: ArtworkType.AUDIO,
                    format: ArtworkFormat.PNG,
                    size: 1000,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 45,
                          height: 45,
                          alignment: AlignmentGeometry.center,
                          margin: EdgeInsets.only(top: 10),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.outer,
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            border: Border.all(color: Colors.white30),
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // --- 1. Big Artwork ---
                      Card(
                        elevation: 5,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        color: Colors.white,
                        margin: EdgeInsets.zero,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: QueryArtworkWidget(
                            id: currentSong.id,

                            artworkBorder: BorderRadius.all(Radius.circular(8)),
                            type: ArtworkType.AUDIO,
                            format: ArtworkFormat.PNG,
                            size: 1000,

                            nullArtworkWidget: Container(
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.music_note,
                                size: 80,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 5),

                      // --- 2. Title & Artist ---
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: isOverflowing
                                ? Marquee(
                                    text: text.capitalizeFirst!,
                                    style: Fontstyle.songN(
                                      22,

                                      Colors.white,
                                      FontWeight.w500,
                                    ),
                                    blankSpace: 50,
                                    velocity: 30,
                                    pauseAfterRound: const Duration(seconds: 1),
                                  )
                                : Text(
                                    text.capitalizeFirst!,
                                    style: Fontstyle.songN(
                                      22,

                                      Colors.white,

                                      FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 10,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.album ?? "Unknown Album",
                                      style: Fontstyle.AlbamN(
                                        18,
                                        FontWeight.w400,
                                        Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    Text(
                                      currentSong.artist ??
                                          "Unknown Artist".toUpperCase(),
                                      style: Fontstyle.artistN(
                                        18,
                                        FontWeight.w500,
                                        Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                foregroundDecoration: BoxDecoration(
                                  color: badgeColor,
                                ),
                                child: Image.asset(
                                  scale: 28,
                                  "lib/assets/icon/hi-res_logo.jpg",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      // --- 3. Progress Bar & Time ---
                      StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration =
                              _audioPlayer.duration ?? Duration.zero;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  padding: EdgeInsets.zero,
                                  trackHeight: 2,
                                  thumbColor: Colors.white,
                                  activeTrackColor: Colors.white54,
                                  inactiveTrackColor: Colors.black26,
                                  overlayShape: SliderComponentShape.noOverlay,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 6,
                                  ),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: duration.inSeconds.toDouble() == 0
                                      ? 1
                                      : duration.inSeconds.toDouble(),
                                  value: position.inSeconds.toDouble().clamp(
                                    0,
                                    duration.inSeconds.toDouble() == 0
                                        ? 1
                                        : duration.inSeconds.toDouble(),
                                  ),
                                  onChanged: (value) {
                                    _audioPlayer.seek(
                                      Duration(seconds: value.toInt()),
                                    );
                                  },
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(position),
                                    style: Fontstyle.navfont(18, Colors.white),
                                  ),
                                  Text(
                                    _formatDuration(duration),
                                    style: Fontstyle.navfont(18, Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      //     SizedBox(height: 20),

                      // --- 4. Controls (Shuffle, Prev, Play/Pause, Next, Loop) ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Shuffle (Visual only for now)

                          // Previous Button
                          IconButton(
                            icon: Icon(
                              Icons.shuffle,
                              // Change color to Pink if active, Grey if inactive
                              color: _isShuffle.value
                                  ? Colors.white
                                  : Colors.black38,
                            ),
                            onPressed: () {
                              _isShuffle.toggle();
                            },
                          ),

                          // --- 2. PREVIOUS BUTTON ---
                          IconButton(
                            icon: Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                              color: Colors.white,
                            ),
                            onPressed: _playPrevious,
                          ),

                          // Play/Pause Big Button
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white24,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                _isPlaying.value
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () {
                                if (_isPlaying.value) {
                                  _audioPlayer.pause();
                                } else {
                                  _audioPlayer.play();
                                }
                              },
                            ),
                          ),

                          // Next Button
                          IconButton(
                            icon: Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                              color: Colors.white,
                            ),
                            onPressed: _playNext,
                          ),

                          IconButton(
                            icon: Icon(
                              _loopMode == LoopMode.one
                                  ? Icons.repeat_one
                                  : Icons.repeat,
                              color: _loopMode == LoopMode.off
                                  ? Colors.black38
                                  : Colors.white,
                            ),
                            onPressed: () {
                              // Cycle through modes: Off -> All -> One -> Off
                              if (_loopMode == LoopMode.off) {
                                _loopMode = LoopMode.all;
                              } else if (_loopMode == LoopMode.all) {
                                _loopMode = LoopMode.one;
                              } else {
                                _loopMode = LoopMode.off;
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_currentIndex.value < widget.songs.length - 1)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.black87,
                            builder: (_) => QueueBottomSheet(
                              songs: widget.songs.obs,
                              currentIndex: widget.initialIndex.obs,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                          color: Colors.black54,
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.white24),

                          // ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.songs[_currentIndex.value + 1].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: Fontstyle.songN(
                                    18,
                                    Colors.white,
                                    FontWeight.normal,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_up_sharp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        left: 15,
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "NEXT",
                            style: Fontstyle.navfont(14, Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
