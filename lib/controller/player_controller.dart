import 'dart:collection';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();

  //Part:- Folder//
  RxList<String> selectedFolders = <String>[].obs;

  //Part:- Cahed song//
  RxList<SongModel> cachedSongs = <SongModel>[].obs;

  //Part:- Artist//
  RxMap<String, int> artistNpic = <String, int>{}.obs;
  RxMap<String, RxList<String>> artisNalbum = <String, RxList<String>>{}.obs;
  RxMap<String, RxList<String>> artistNsongnumber =
      <String, RxList<String>>{}.obs;

  //Part:- Album//
  RxMap<String, int> albumNpic = <String, int>{}.obs;
  RxMap<String, RxList<SongModel>> albumNsong =
      <String, RxList<SongModel>>{}.obs;

  //Part folder song//
  RxMap<String, int> folderNpic = <String, int>{}.obs;
  RxMap<String, RxList<SongModel>> folderSong =
      <String, RxList<SongModel>>{}.obs;

  void addFolder(String folderPath) {
    if (!selectedFolders.contains(folderPath)) {
      selectedFolders.add(folderPath);
      //folderSong[folderPath];
      fetchSongs();
    }
  }

  // Fetch songs from selected folders and cache them
  // Fetch songs from selected folders and cache them
  Future<void> fetchSongs() async {
    // --- FIX 1: Ask for permission before fetching ---
    // This prevents the "Application doesn't have access to the library" crash
    var status = await Permission.audio.status;
    if (!status.isGranted) {
      status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.audio.request();
        await Permission.storage.request();
      }
    }

    try {
      List<SongModel> allSongs = await audioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      // --- FIX 2: Show ALL songs if no folder is picked ---
      // If selectedFolders is empty, show everything. Otherwise, filter.
      List<SongModel> filteredSongs;

      if (selectedFolders.isEmpty) {
        filteredSongs = allSongs;
      } else {
        // Normalize folder paths (add trailing slash)
        final normalizedFolders = selectedFolders
            .map((folder) => folder.endsWith('/') ? folder : '$folder/')
            .toList();

        // Filter songs from selected folders only
        filteredSongs = allSongs.where((song) {
          final songPath = song.data.endsWith('/')
              ? song.data
              : '${song.data}/';
          return normalizedFolders.any((folder) => songPath.startsWith(folder));
        }).toList();
      }

      // Remove duplicates
      final uniqueSongs = filteredSongs.toSet().toList();

      cachedSongs.assignAll(uniqueSongs);
    } catch (e) {
      print("Error fetching songs: $e");
    }

    // Resume your existing logic
    artist();
    album();
    folder();
  }

  Future<void> artist() async {
    // print(
    //     "-------------------------------------------------This is inside Artist");
    List<String> TempArtist = <String>[];
    for (var song in cachedSongs) {
      // if (!TempArtist.contains(song.artist)) {
      //   TempArtist.add(song.artist!);
      // }
      TempArtist.add(song.artist!);
    }

    final uniqueArtist = LinkedHashSet<String>.from(TempArtist).toList();

    for (String unArtistName in uniqueArtist) {
      print(unArtistName);
      for (var song in cachedSongs) {
        //print(song.artist);
        if (unArtistName == song.artist) {
          // String unArtistName = song.artist == "<unknown>"
          //     ? "Unknown Album"
          //     : song.album ?? "Unknown Album";
          artistNpic.putIfAbsent(unArtistName, () => song.id);
          artisNalbum.putIfAbsent(unArtistName, () => <String>[].obs);
          if (!artisNalbum[unArtistName]!.contains(song.album)) {
            artisNalbum[unArtistName]!.add(
              song.album!,
              //!= "<unknown>" ? song.album! : "Unknown Album"
            );
          }
          artistNsongnumber.putIfAbsent(unArtistName, () => <String>[].obs);
          artistNsongnumber[unArtistName]?.add(song.title);
          //artistNsongnumber.putIfAbsent(unArtistName, () => );
        }
      }
    }
    // for (var a in artistNpic.entries) {
    //   print("${a.key}: ${a.value}");
    // }
  }

  Future<void> album() async {
    // print(
    //     "-------------------------------------------------This is inside album");
    List<String> TempAlbum = <String>[];
    for (var song in cachedSongs) {
      TempAlbum.add(song.album!);
    }

    final uniqueAlbum = LinkedHashSet<String>.from(TempAlbum).toList();
    //print(uniqueAlbum);
    for (String unAlbumName in uniqueAlbum) {
      for (var song in cachedSongs) {
        if (unAlbumName == song.album) {
          //print("unAlbumName: $unAlbumName song.album: ${song.album}");
          albumNpic.putIfAbsent(unAlbumName, () => song.albumId!);
          albumNsong.putIfAbsent(unAlbumName, () => <SongModel>[].obs);
          // String albumName = song.artist == "<unknown>"
          //     ? "Unknown Album"
          //     : song.album ?? "Unknown Album";

          if (!albumNsong[unAlbumName]!.contains(song)) {
            //albumNsong.putIfAbsent(unAlbumName, () => <SongModel>[].obs);
            albumNsong[unAlbumName]!.add(song);
          }
          //albumNsong[unAlbumName]!.add(song);
        }
      }
    }

    // for (var a in albumNsong.entries) {
    //   print("${a.key}: ${a.value}");
    // }
  }

  Future<void> folder() async {
    print(
      "-------------------------------------------------This is inside folder",
    );
    // "/storage/emulated/0/#Music New era/The Great Exception"
    // "{_uri: content://media/external/audio/media/1000372282, artist: LMYK,
    // year: null, is_music: true, title: 0 (zero), genre_id: null, _size: 27430307,
    // duration: 217808, is_alarm: false, _display_name_wo_ext: LMYK   0 (zero),
    // album_artist: null, genre: null, is_notification: false, track: 1,
    // _data: /storage/emulated/0/#Music New era/The Great Exception/LMYK   0 (zero).flac,
    // _display_name: LMYK   0 (zero).flac, album: 0 (zero), composer: null,
    // is_ringtone: false, artist_id: 8446103442953737881, is_podcast: false,
    // bookmark: 0, date_added: 1737322044, is_audiobook: false,
    // date_modified: 1676356734, album_id: 9020107692431209244
    // file_extension: flac, _id: 1000372282}"

    List<String> Tempfolder = <String>[];
    for (var song in cachedSongs) {
      final rep1 = song.data.replaceAll(song.displayName, '');
      Tempfolder.add(rep1);
    }
    final uniquefolder = LinkedHashSet<String>.from(Tempfolder).toList();

    for (String folder in uniquefolder) {
      String nfolder = folder.replaceAll("/storage/emulated/0/", '');
      //print(nfolder);
      for (var song in cachedSongs) {
        final songFolderPath = song.data
            .replaceAll(song.displayName, '')
            .replaceAll("/storage/emulated/0/", '')
            .trim();
        //print(songFolderPath);
        if (nfolder == songFolderPath) {
          folderNpic.putIfAbsent(songFolderPath, () => song.id);
          folderSong.putIfAbsent(songFolderPath, () => <SongModel>[].obs);
          if (!folderSong[songFolderPath]!.contains(song)) {
            folderSong[songFolderPath]!.add(song);
          }
        }
      }
    }

    for (var a in folderSong.entries) {
      print("${a.key}: ${a.value.length}");
    }
  }

  // Pre-fetch artwork for all cached songs (optional)
  // Future<void> _prefetchArtwork() async {
  //   songsWithArtwork.clear();
  //   for (final song in cachedSongs) {
  //     try {
  //       final artwork = await audioQuery.queryArtwork(
  //           song.id, ArtworkType.AUDIO,
  //           format: ArtworkFormat.JPEG, size: 1000);
  //       songsWithArtwork.add(SongWithArtwork(song: song, artwork: artwork));
  //     } catch (e) {
  //       songsWithArtwork.add(SongWithArtwork(song: song, artwork: null));
  //     }
  //   }
  // }

  String formatDuration(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
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
                // Use a try-catch block here because FilePicker can be buggy on some Android versions
                try {
                  String? folderPath = await FilePicker.platform
                      .getDirectoryPath();

                  if (folderPath != null) {
                    // FIX 3: Force update the UI
                    addFolder(folderPath);
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print("Error picking folder: $e");
                  // Optional: Show a snackbar saying "Could not pick folder"
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

class SongWithArtwork {
  final SongModel song;
  final Uint8List? artwork;

  SongWithArtwork({required this.song, required this.artwork});
}
