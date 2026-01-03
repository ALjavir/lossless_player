import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Genres extends StatefulWidget {
  const Genres({super.key});

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(),
          onPressed: () async {
            var status = await Permission.storage.request();
            if (status.isGranted) {
              //permissionn.value = true;
              print(
                  ".......................................Permission Granted");
            } else if (status.isDenied) {
              await Permission.storage.request();
              print(".......................................Permission Denied");
            }
          },
          child: Text('Scan', style: TextStyle(color: Colors.black)),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: GridView.count(
      //     physics: ScrollPhysics(),
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 5,
      //     mainAxisSpacing: 5,
      //     shrinkWrap: true,
      //     children: List.generate(
      //       20,
      //       (index) {
      //         return Container(
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //                 fit: BoxFit.cover,
      //                 image: AssetImage(
      //                   'assets/icon/1.png',
      //                 )),
      //           ),
      //           child: Container(
      //             //height: 30,
      //             color: Colors.black.withOpacity(0.5),
      //             alignment: Alignment.center,
      //             child: Text(
      //               " Rock ",
      //               style: Fontstyle.appbarfont(40, Colors.white),
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Genres extends StatefulWidget {
//   const Genres({super.key});

//   @override
//   State<Genres> createState() => _GenresState();
// }

// class _GenresState extends State<Genres> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await requestStoragePermission();
//           },
//           child: Text('Scan', style: TextStyle(color: Colors.black)),
//         ),
//       ),
//     );
//   }

//   Future<void> requestStoragePermission() async {
//     // Request storage permission
//     var status = await Permission.audio.request();
//     if (status.isGranted) {
//       //permissionn.value = true;
//       print(".......................................Permission Granted");
//     } else if (status.isDenied) {
//       await Permission.storage.request();
//       print(".......................................Permission Denied");
//     }
//   }
// }
