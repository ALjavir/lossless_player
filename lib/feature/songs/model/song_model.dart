import 'dart:typed_data';

class SongModel {
  final String id;
  final String displayName;
  final String artist;
  final String album;
  final String path;
  final int duration;
  final Uint8List? artwork; // Kept in memory, usually not saved to DB
  final bool isFavorite;

  SongModel({
    required this.id,
    required this.displayName,
    required this.artist,
    required this.album,
    required this.path,
    required this.duration,
    this.artwork,
    this.isFavorite = false,
  });

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'],
      path: map['path'],
      displayName: map['displayName'] ?? 'Unknown',
      artist: map['artist'] ?? 'Unknown Artist',
      album: map['album'] ?? 'Unknown Album',
      duration: map['duration'] ?? 0,
      artwork: map['artwork'], // Expects Uint8List or null
      // Fix: If map is 1 (true) in DB, set true. Default to false.
      isFavorite: map['isFavorite'] == 1 || map['isFavorite'] == true,
    );
  }

  // You will still need this later to save to SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'displayName': displayName,
      'artist': artist,
      'album': album,
      'duration': duration,
      // 'artwork': artwork, // <-- WARNING: Don't save raw image bytes to DB usually
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}
