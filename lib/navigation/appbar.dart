import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lossless_player/style/font.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? leading;
  const Appbar({super.key, this.leading});

  @override
  State<Appbar> createState() => _AppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.all(0),
      elevation: 5,
      shadowColor: Colors.black26,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 200,
            sigmaY: 200,
            tileMode: TileMode.mirror,
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                //   padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            forceMaterialTransparency: true,
            leadingWidth: 70,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'TIDAL',
                      style: Fontstyle.appbarfont(14, Colors.black),
                    ),
                    TextSpan(
                      text: 'x\n',
                      style: Fontstyle.appbarfont(16, Colors.red),
                    ),
                    TextSpan(
                      text: 'JAVIR',
                      style: Fontstyle.appbarfont(18, Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
