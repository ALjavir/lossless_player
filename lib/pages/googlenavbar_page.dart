// import 'package:flutter/material.dart';
// import 'package:music_player/pages/song_home_page.dart';
// import 'package:music_player/pages/like_page.dart';

// class GooglenavbarPage extends StatefulWidget {
//   const GooglenavbarPage({super.key});

//   @override
//   State<GooglenavbarPage> createState() => _GooglenavbarPageState();
// }

// class _GooglenavbarPageState extends State<GooglenavbarPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(
//               text: "Home",
//               icon: Icon(Icons.circle),
//             ),
//             Tab(
//               text: "Like",
//               icon: Icon(Icons.person),
//             ),
//           ],
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.black,
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const [
//           Homepage(),
//           LikePage(),
//         ],
//       ),
//     );
//   }
// }
