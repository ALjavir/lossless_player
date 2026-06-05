import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lossless_player/style/font.dart';
import 'package:lossless_player/feature/global/song_contaner.dart';

class Albam extends StatefulWidget {
  final List<String> albamName;
  final String artistName;

  const Albam({super.key, required this.albamName, required this.artistName});

  @override
  State<Albam> createState() => _AlbamState();
}

class _AlbamState extends State<Albam> {
  Set<int> expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.albamName.length,

      itemBuilder: (context, index) {
        return Card(
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          color: Colors.white,
          margin: EdgeInsets.zero,
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
            childrenPadding: EdgeInsets.symmetric(horizontal: 4),

            minTileHeight: 0,
            tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            title: Text(
              widget.albamName[index].capitalizeFirst!,
              style: Fontstyle.AlbamN(
                18,
                FontWeight.w400,
                expandedItems.contains(index) ? Colors.black87 : Colors.black38,
              ),
            ),

            iconColor: Colors.black,

            onExpansionChanged: (expanded) {
              setState(() {
                if (expanded) {
                  expandedItems.add(index);
                } else {
                  expandedItems.remove(index);
                }
              });
            },

            children: [
              SongContaner(
                buildCondition: widget.albamName[index],
                buildCondition1: widget.artistName,
              ),
            ],
          ),
        );
      },
    );
  }
}
         // Obx(
              //   () => Column(
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             widget.albamName[index].toUpperCase(),
              //             style: Fontstyle.songN(
              //               16,
              //               isExpanded == true ? Colors.black : Colors.black45,
              //               FontWeight.normal,
              //             ),
              //           ),
              //           IconButton(
              //             onPressed: () {
              //               isExpanded.value = !isExpanded.value;
              //             },
              //             icon: Icon(
              //               isExpanded.value
              //                   ? Icons.keyboard_arrow_down
              //                   : Icons.keyboard_arrow_up,
              //               size: 20,
              //             ),
              //           ),
              //         ],
              //       ),
              //       AnimatedSize(
              //         duration: const Duration(milliseconds: 0),
              //         curve: Curves.easeInToLinear,
              //         child: isExpanded.value
              //             ? SongContaner(
              //                 buildCondition: widget.albamName[index],
              //                 buildCondition1: widget.artistName,
              //               )
              //             : const SizedBox.shrink(),
              //       ),
              //     ],
              //   ),
              // ),