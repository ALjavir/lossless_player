import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:lossless_player/feature/songs/model/song_model.dart'; // Ensure you have this

class HomeController extends GetxController {
  RxList<String> selectedFolders = <String>[].obs;
  RxList<SongModel> cachedSongs = <SongModel>[].obs;

  var isLoading = false.obs;

  Future<void> pickAndLoadFolder(String rootFolderPath) async {
    try {
      isLoading.value = true;

      if (!selectedFolders.contains(rootFolderPath)) {
        selectedFolders.add(rootFolderPath);
      }

      Directory dir = Directory(rootFolderPath);
      if (!await dir.exists()) return;

      List<FileSystemEntity> allFiles = dir.listSync(recursive: true);

      List<SongModel> newSongs = [];

      for (var file in allFiles) {
        if (file is File && _isAudioFile(file.path)) {
          Map<String, dynamic> songData = await _generateSongMap(file);

          // B. Convert using your ONLY format: fromMap
          SongModel song = SongModel.fromMap(songData);

          newSongs.add(song);
        }
      }

      // STEP 4: Update the UI List
      cachedSongs.addAll(newSongs);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Helper: Reads file and returns the MAP format you want
  Future<Map<String, dynamic>> _generateSongMap(File file) async {
    try {
      final metadata = await MetadataRetriever.fromFile(file);

      return {
        'id': file.path.hashCode.toString(),
        'path': file.path,
        'displayName': metadata.trackName ?? file.path.split('/').last,
        'artist': metadata.trackArtistNames?.first ?? "Unknown Artist",
        'album': metadata.albumName ?? "Unknown Album",
        'duration': metadata.trackDuration ?? 0,
        'artwork': metadata.albumArt,
        'isFavorite': false,
        'fileExtention': file.path.split('.').last.toUpperCase(),
      };
    } catch (e) {
      return {
        'id': file.path.hashCode.toString(),
        'path': file.path,
        'displayName': file.path.split('/').last,
        'artist': "Unknown",
        'album': "Unknown",
        'duration': 0,
        'artwork': null,
        'isFavorite': false,
      };
    }
  }

  bool _isAudioFile(String path) {
    final ext = path.toLowerCase();
    return ext.endsWith('.mp3') ||
        ext.endsWith('.m4a') ||
        ext.endsWith('.flac');
  }

  Future<void> showdiolog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Folder'),
          content: Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: selectedFolders.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(selectedFolders[index]));
              },
            );
          }),
          actions: [
            FloatingActionButton.small(
              onPressed: () async {
                String? folderPath = await FilePicker.platform
                    .getDirectoryPath();
                if (folderPath != null) {
                  pickAndLoadFolder(folderPath);
                  Navigator.pop(context);
                }
              },
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ],
        );
      },
    );
  }
}
