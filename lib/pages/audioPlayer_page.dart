import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioplayerPage extends StatefulWidget {
  final String songPath;
  const AudioplayerPage({super.key, required this.songPath});

  @override
  State<AudioplayerPage> createState() => _AudioplayerPageState();
}

class _AudioplayerPageState extends State<AudioplayerPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setFilePath(widget.songPath);
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(widget.songPath), Controlls(audioPlayer: _audioPlayer)],
      ),
    );
  }
}

class Controlls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controlls({super.key, required this.audioPlayer});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playState = snapshot.data;
        final processingState = playState?.processingState;
        final playing = playState?.playing;

        if (!(playing ?? false)) {
          return IconButton(
              onPressed: () => audioPlayer.play(),
              icon: Icon(Icons.play_circle_filled_outlined));
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
              onPressed: () => audioPlayer.pause(),
              icon: Icon(Icons.pause_circle));
        }
        return Icon(Icons.play_arrow_rounded);
      },
    );
  }
}
