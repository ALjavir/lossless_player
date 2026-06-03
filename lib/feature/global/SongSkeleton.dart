import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SongSkeleton extends StatelessWidget {
  const SongSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        spacing: 12,
        children: [
          Icon(Icons.circle, size: 60),

          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
