// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:lossless_audio/controller/player_controller.dart';
// import 'package:lossless_audio/style/font.dart';
// import 'package:lossless_audio/widget/song_contaner.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class SongHomePage extends StatefulWidget {
//   const SongHomePage({super.key});

//   @override
//   State<SongHomePage> createState() => _SongHomePageState();
// }

// class _SongHomePageState extends State<SongHomePage> {
//   //List<String> audioFiles = [];

//   final PlayerController controller = Get.put(PlayerController());
//   //RxList<SongModel> cachedSongs = <SongModel>[].obs;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: GetBuilder<PlayerController>(builder: (controller) {
//           if (controller.selectedFolders.isEmpty) {
//             print(
//                 "-----------------------------------this is Part: 1--------------------------------");
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Permission folder access'),
//                   content: Text('Please select an audio storage folder.'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => SystemNavigator.pop(),
//                       child: Text("Cancel"),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         String? folderPath =
//                             await FilePicker.platform.getDirectoryPath();
//                         if (folderPath != null) {
//                           controller.addFolder(folderPath);
//                         }
//                       },
//                       child: Text("Select Folder"),
//                     ),
//                   ],
//                 ),
//               );
//             });

//             return SizedBox.shrink();
//           } else {
//             print(
//                 "-----------------------------------this is Part: 2---------------------------------");
//             // If permission is granted, show the main UI
//             return FutureBuilder<List<SongModel>>(
//               future: controller.audioQuery.querySongs(), // Fetch songs
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   // Show a loading indicator while fetching data
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   // Handle errors during fetching
//                   return Center(child: Text("Error: ${snapshot.error}"));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   // Display a message if no songs are found
//                   return Center(
//                     child: Text("No songs found!"),
//                   );
//                 } else {
//                   // Songs are successfully fetched
//                   print(
//                       "-----------------------------------this is Part: 3--------------------------------");
//                   for (int i = 0; i < snapshot.data!.length; i++) {
//                     print("${snapshot.data![i]}\n");
//                   }
//                   final songs = snapshot.data!;

//                   return SingleChildScrollView(
//                     padding: EdgeInsets.only(left: 4),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Songs",
//                           style: Fontstyle.thambalfont(30, Colors.black),
//                         ),
//                         ListView.separated(
//                           shrinkWrap: true, // Prevent overflow issues
//                           physics:
//                               const NeverScrollableScrollPhysics(), // Disable nested scrolling
//                           itemCount: songs
//                               .length, // Use the length of the fetched songs list
//                           separatorBuilder: (context, index) => const Divider(),
//                           itemBuilder: (context, index) {
//                             final song = songs[
//                                 index]; // Use the fetched songs list directly

//                             return FutureBuilder<Uint8List?>(
//                               future: controller.audioQuery
//                                   .queryArtwork(song.id, ArtworkType.AUDIO),
//                               builder: (context, artworkSnapshot) {
//                                 final artwork = artworkSnapshot.data;
//                                 return SongContaner(
//                                   coverImage: artwork,
//                                   name: song.title,
//                                   artist: song.artist ?? "Unknown Artist",
//                                   albam: song.album ?? "Unknown Album",
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             );
//           }
//           // else {
//           //   print(
//           //       "-----------------------------------this is Part: 2---------------------------------");
//           //   // If permission is granted, show the main UI
//           //   return FutureBuilder<List<SongModel>>(
//           //       future: controller.audioQuery.querySongs(), // Fetch songs
//           //       builder: (context, snapshot) {
//           //         if (snapshot.connectionState == ConnectionState.waiting) {
//           //           // Show a loading indicator while fetching data
//           //           return const Center(child: CircularProgressIndicator());
//           //         } else if (snapshot.hasError) {
//           //           // Handle errors during fetching
//           //           return Center(child: Text("Error: ${snapshot.error}"));
//           //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           //           // Display a message if no songs are found
//           //           return Center(
//           //             child: Text("No songs found!"),
//           //           );
//           //         } else {
//           //           // Songs are successfully fetched
//           //           print(
//           //               "-----------------------------------this is Part: 3--------------------------------");
//           //           for (int i = 0; i < snapshot.data!.length; i++) {
//           //             print("$snapshot.data[i]\n");
//           //           }
//           //           final songs = snapshot.data!;

//           //           return SingleChildScrollView(
//           //               padding: EdgeInsets.only(left: 4),
//           //               child: Column(
//           //                 children: [
//           //                   Text(
//           //                     "Songs",
//           //                     style: Fontstyle.thambalfont(30, Colors.black),
//           //                   ),
//           //                   ListView.separated(
//           //                     shrinkWrap: true, // Prevent overflow issues
//           //                     physics:
//           //                         const NeverScrollableScrollPhysics(), // Disable nested scrolling
//           //                     itemCount: songs.length,
//           //                     separatorBuilder: (context, index) =>
//           //                         const Divider(),
//           //                     itemBuilder: (context, index) {
//           //                       //final songData = controller.songs[index];
//           //                       //final song = songData['song'] as SongModel;
//           //                       //final artwork = songData['artwork'] as Uint8List?;
//           //                       final songData = controller.songs[index];

//           //                       return SongContaner(
//           //                         coverImage: songData.artwork,
//           //                         name: songData.song.title,
//           //                         artist:
//           //                             songData.song.artist ?? "Unknown Artist",
//           //                         albam: songData.song.album ?? "Unknown Album",
//           //                       );
//           //                     },
//           //                   ),
//           //                 ],
//           //               ));
//           //         }
//           //         });
//           // }
//         }));
//   }
// }
//////////////////////////////////////////////song content/////////////////////////////////////////
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:lossless_audio/style/font.dart';

// class SongContaner extends StatefulWidget {
//   final Uint8List? coverImage;
//   final String name;
//   final String artist;
//   final String albam;
//   final String? endtime;
//   final String formate;

//   const SongContaner(
//       {super.key,
//       this.coverImage,
//       required this.name,
//       required this.artist,
//       required this.albam,
//       this.endtime,
//       required this.formate});

//   @override
//   State<SongContaner> createState() => _SongContanerState();
// }

// //Color hificolor = Colors.black;
// //Color nonhificolor = Colors.black45;

// class _SongContanerState extends State<SongContaner> {
//   @override
//   Widget build(BuildContext context) {
//     final Color badgeColor =
//         ["mp3", "aac"].contains(widget.formate.toLowerCase())
//             ? Colors.black12 // Non-HiFi color
//             : Colors.black; // HiFi color
//     print(widget.formate);
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(4),
//       height: 80,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 35,
//             backgroundImage: widget.coverImage != null
//                 ? MemoryImage(widget.coverImage!)
//                 : null,
//             child: widget.coverImage == null
//                 ? Icon(
//                     Icons.music_note,
//                     size: 40,
//                     color: Colors.black,
//                   )
//                 : null,
//           ),
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.name,
//                     style: Fontstyle.songN(16),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     softWrap: false,
//                   ),
//                   Text(
//                     widget.albam,
//                     style: Fontstyle.AlbamN(12, FontWeight.normal),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     softWrap: false,
//                   ),
//                   Text(
//                     widget.artist,
//                     style: Fontstyle.artistN(12),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     softWrap: false,
//                   ),
//                   Text(
//                     widget.endtime.toString(),
//                     style: Fontstyle.AlbamN(12, FontWeight.normal),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     softWrap: false,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           //Expanded(child: Container()),

//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(onPressed: () {}, icon: Icon(Icons.add_circle)),
//               Row(
//                 spacing: 5.0,
//                 children: [
//                   Text(
//                     widget.formate.toLowerCase(),
//                     style: Fontstyle.thambalfont(14, Colors.black),
//                   ),
//                   Container(
//                     width: 40,
//                     decoration: BoxDecoration(
//                         color: badgeColor,
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     child: Text(
//                       "HI-FI",
//                       textAlign: TextAlign.center,
//                       style: Fontstyle.thambalfont(14, Colors.white),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
