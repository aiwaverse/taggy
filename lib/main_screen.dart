import 'package:flutter/material.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';
import 'package:taggy/main_screen_add_popup.dart';

import 'image_grid.dart';
import 'main_screen_popup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Gallery gallery = Gallery();
  void addFolder(String folder) {
    setState(() {
      gallery.addFolder(folder);
    });
  }

  void addFiles(List<String> files) {
    setState(() {
      gallery.addFiles(files);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryMedium,
        foregroundColor: AppColors.neutralDark,
        leading: Padding(
            padding: const EdgeInsets.all(6),
            child: AddPopup(
              addFolder: addFolder,
              addImages: addFiles,
            )),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(6),
              child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPure,
                      shape: const CircleBorder(),
                      fixedSize: const Size(48, 48)),
                  child: const Icon(Icons.search,
                      color: AppColors.neutralDarker, size: 24))),
          const Padding(padding: EdgeInsets.all(6), child: MainScreenPopup())
        ],
      ),
      backgroundColor: AppColors.baseLight,
      body: gallery.isEmpty
          ? const Center(
              child: Text(
                "Clique no botão + para adicionar imagens e pastas a sua galeria.",
                style: TextStyles.h1,
              ),
            )
          : ImageGrid(
              gallery: gallery,
            ),
    );
  }
}
