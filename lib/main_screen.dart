import 'package:flutter/material.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';

import 'package:taggy/entities/search.dart';
import 'package:taggy/entities/storage.dart';
import 'package:taggy/main_screen_add_popup.dart';
import 'package:taggy/search_screen.dart';

import 'image_grid.dart';
import 'main_screen_popup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.searchOptions});
  final Search? searchOptions;
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late GalleryStorage galleryStorage;
  List<GalleryItem> galleryItems = [];
  @override
  void initState() {
    super.initState();
    galleryStorage = GalleryStorageMock();
    if (widget.searchOptions == null) {
      galleryItems = galleryStorage.getAllItems();
    } else {
      galleryItems = galleryStorage.search(widget.searchOptions!);
    }
  }

  Future<void> addFolder(String folder) async {
    galleryStorage.getCompleteGallery().addFolder(folder);
    await galleryStorage.getCompleteGallery().refresh();
    setState(() {
      galleryItems = galleryStorage.getAllItems();
    });
  }

  void addFiles(List<String> files) {
    galleryStorage.getCompleteGallery().addFiles(files);
    setState(() {
      galleryItems = galleryStorage.getAllItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryMedium,
        foregroundColor: AppColors.neutralDark,
        leading: ModalRoute.of(context)?.canPop == true
            ? const BackButton()
            : Padding(
                padding: const EdgeInsets.all(6),
                child: AddPopup(
                  addFolder: addFolder,
                  addImages: addFiles,
                )),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(6),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(
                            avaliableTags: galleryItems
                                .map((item) => item.tags)
                                .expand((x) => x))));
                  },
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: AppColors.primaryPure,
                      shape: const CircleBorder(),
                      fixedSize: const Size(48, 48)),
                  child: const Icon(Icons.search,
                      color: AppColors.neutralDarker, size: 24))),
          const Padding(padding: EdgeInsets.all(6), child: MainScreenPopup())
        ],
      ),
      backgroundColor: AppColors.baseLight,
      body: galleryItems.isEmpty
          ? const Center(
              child: Text(
                "Clique no botão + para adicionar imagens e pastas a sua galeria.",
                style: TextStyles.h1,
                textAlign: TextAlign.center,
              ),
            )
          : ImageGrid(
              galleryItems: galleryItems,
            ),
    );
  }
}
