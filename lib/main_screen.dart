import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/directory.dart';
import 'package:taggy/entities/gallery_item.dart';

import 'package:taggy/entities/search.dart';
import 'package:taggy/services/gallery_item_service.dart';
import 'package:taggy/storage.dart';
import 'package:taggy/main_screen_add_popup.dart';
import 'package:taggy/search_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'image_grid.dart';
import 'main_screen_popup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.searchOptions});
  final Search? searchOptions;
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GalleryItem> galleryItems = [];
  bool hasItems = false;
  late GalleryStorageSQLite storage;

  Future<List<GalleryItem>> getItemsFirstTime() async {
    var directories = await storage.directoryRepository.getAll();
    await Future.wait(directories.map((dir) =>
        GalleryItemService.scanForImages(storage.galleryItemRepository, dir)));
    hasItems = await storage.galleryItemRepository.hasItems() ||
        await storage.directoryRepository.hasItems();

    if (widget.searchOptions == null) {
      return await storage.galleryItemRepository
          .getPaginatedFirstPage(count: 21);
    } else {
      return await storage.galleryItemRepository
          .getWithSearchFirstPage(widget.searchOptions!, count: 21);
    }
  }

  @override
  void initState() {
    super.initState();
    storage = context.read<GalleryStorageSQLite>();
    getItemsFirstTime().then((items) => setState(() => galleryItems = items));
  }

  Future<void> addFolder(String path) async {
    await storage.directoryRepository.insert(Directory(path));
    var items = await getItemsFirstTime();
    setState(() {
      galleryItems = items;
    });
  }

  void addFiles(List<String> files) async {
    for (var file in files) {
      var f = File(file);
      await storage.galleryItemRepository
          .insert(GalleryItem(f.path, (await f.stat()).modified));
    }
    var items = await getItemsFirstTime();
    setState(() {
      galleryItems = items;
    });
  }

  Future<void> advancePage() async {
    var items = widget.searchOptions == null
        ? await storage.galleryItemRepository.getPaginated(
            galleryItems[galleryItems.length - 2], true, count: 21)
        : await storage.galleryItemRepository.getWithSearch(
            widget.searchOptions!, galleryItems[galleryItems.length - 2], true,
            count: 21);
    setState(() {
      galleryItems = items;
    });
  }

  Future<void> goBackPage() async {
    var items = widget.searchOptions == null
        ? await storage.galleryItemRepository
            .getPaginated(galleryItems.first, false, count: 21)
        : await storage.galleryItemRepository.getWithSearch(
            widget.searchOptions!, galleryItems.first, false,
            count: 21);
    setState(() {
      galleryItems = items;
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
              child: widget.searchOptions == null ||
                      widget.searchOptions.toString().isEmpty
                  ? Tooltip(
                      message: AppLocalizations.of(context)!.search,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: AppColors.primaryPure,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.search,
                              color: AppColors.neutralDarker, size: 24)))
                  : ElevatedButton(
                      style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryPure),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(26)))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                              child: Text(
                                widget.searchOptions!.toString(),
                                style: TextStyles.button.copyWith(
                                    color: AppColors.neutralDarker,
                                    overflow: TextOverflow.ellipsis),
                              )),
                          const Icon(Icons.search,
                              color: AppColors.neutralDarker, size: 24)
                        ],
                      ))),
          const Padding(padding: EdgeInsets.all(6), child: MainScreenPopup())
        ],
      ),
      backgroundColor: AppColors.baseLight,
      body: hasItems
          ? Provider.value(
              value: galleryItems,
              child: ImageGrid(
                galleryItems: galleryItems,
                onSearch: widget.searchOptions != null,
                advancePage: advancePage,
                goBackPage: goBackPage,
              ))
          : Center(
              child: Text(
                AppLocalizations.of(context)!.addToGalleryMessage,
                style: TextStyles.h1.copyWith(color: AppColors.neutralDarker),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
