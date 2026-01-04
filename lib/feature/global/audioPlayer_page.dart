import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
  late int _currentIndex;
  bool _isPlaying = false;
  bool _isShuffle = false;
  LoopMode _loopMode = LoopMode.off;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.initialIndex; // Set starting song
    _loadSong();

    // Listen to player state for UI updates
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
      // Auto-play next song when current finishes
      if (state.processingState == ProcessingState.completed) {
        _playNext();
      }
    });
  }

  Future<void> _loadSong() async {
    try {
      await _audioPlayer.setFilePath(widget.songs[_currentIndex].data);
      _audioPlayer.play();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _loadSong();
    }
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
    } else if (_isShuffle) {
      // If Shuffle is on, pick a random song
      setState(() {
        _currentIndex = Random().nextInt(widget.songs.length);
      });
      _loadSong();
    } else {
      // Normal Logic
      if (_currentIndex < widget.songs.length - 1) {
        setState(() {
          _currentIndex++;
        });
        _loadSong();
      } else if (_loopMode == LoopMode.all) {
        // If at the end AND Repeat All is on, go back to start
        setState(() {
          _currentIndex = 0;
        });
        _loadSong();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current song details
    final currentSong = widget.songs[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Now Playing",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- 1. Big Artwork ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // Simple shadow for depth
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 5,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: QueryArtworkWidget(
                    id: currentSong.id,
                    type: ArtworkType.AUDIO,

                    size: 3000,

                    quality: 100,

                    format: ArtworkFormat.JPEG,

                    artworkFit: BoxFit.cover,

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
            ),

            SizedBox(height: 30),

            // --- 2. Title & Artist ---
            Text(
              currentSong.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              currentSong.artist ?? "Unknown Artist",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 30),

            // --- 3. Progress Bar & Time ---
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = _audioPlayer.duration ?? Duration.zero;

                return Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.pinkAccent,
                        activeTrackColor: Colors.pinkAccent,
                        inactiveTrackColor: Colors.pink[100],
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                      ),
                      child: Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble().clamp(
                          0,
                          duration.inSeconds.toDouble(),
                        ),
                        onChanged: (value) {
                          _audioPlayer.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(position),
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            _formatDuration(duration),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 20),

            // --- 4. Controls (Shuffle, Prev, Play/Pause, Next, Loop) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Shuffle (Visual only for now)
                IconButton(
                  icon: Icon(Icons.shuffle, color: Colors.grey),
                  onPressed: () {},
                ),

                // Previous Button
                IconButton(
                  icon: Icon(
                    Icons.skip_previous_rounded,
                    size: 40,
                    color: Colors.black87,
                  ),
                  onPressed: _playPrevious,
                ),

                // Play/Pause Big Button
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.4),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      if (_isPlaying) {
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
                    color: Colors.black87,
                  ),
                  onPressed: _playNext,
                ),

                // Loop (Visual only for now)
                IconButton(
                  icon: Icon(Icons.repeat, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
