import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:lossless_player/feature/home/contoller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    if (homeController.selectedFolders.isEmpty) {
      homeController.showdiolog(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: Column(children: [

        ],
       )),
    );
  }
}
