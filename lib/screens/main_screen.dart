import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taggy/utils/constants/app_colors.dart';
import 'package:taggy/utils/constants/text_styles.dart';
import 'package:taggy/entities/directory.dart';
import 'package:taggy/entities/gallery_item.dart';

import 'package:taggy/entities/search.dart';
import 'package:taggy/services/gallery_item_service.dart';
import 'package:taggy/storage.dart';
import 'package:taggy/screens/main_screen_add_popup.dart';
import 'package:taggy/screens/search_screen.dart';

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
  List<GalleryItem>? galleryItems;
  bool hasItems = true;
  late GalleryStorageSQLite storage;

  Future<void> _permissionsWarning() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.permissionsTitle),
            content: Text(
              AppLocalizations.of(context)!.imagePermissionsDisclaimer,
              textAlign: TextAlign.justify,
            )));
  }

  Future<List<GalleryItem>> getItemsFirstTime() async {
    hasItems = await storage.galleryItemRepository.hasItems() ||
        await storage.directoryRepository.hasItems();
    if (widget.searchOptions == null) {
      var directories = await storage.directoryRepository.getAll();
      await Future.wait(directories.map((dir) =>
          GalleryItemService.scanForImages(storage.galleryItemRepository,
              storage.permissionRepository, dir, _permissionsWarning)));

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
    //getItemsFirstTime().then((items) => setState(() => galleryItems = items));
  }

  Future<void> refresh() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Scanning folders")));
    var items = await getItemsFirstTime();
    setState(() {
      galleryItems = items;
    });
  }

  Future<void> addFolder(String path) async {
    await storage.directoryRepository.insert(Directory(path));
    await refresh();
  }

  void addFiles(List<String> files) async {
    for (var file in files) {
      var f = File(file);
      await storage.galleryItemRepository
          .insert(GalleryItem(f.path, (await f.lastModified())));
    }
    await refresh();
  }

  Future<void> advancePage() async {
    var items = widget.searchOptions == null
        ? await storage.galleryItemRepository
            .getPaginated(galleryItems!.last, true, count: 21)
        : await storage.galleryItemRepository.getWithSearch(
            widget.searchOptions!, galleryItems!.last, true,
            count: 21);
    setState(() {
      galleryItems = items;
    });
  }

  Future<void> goBackPage() async {
    var items = widget.searchOptions == null
        ? await storage.galleryItemRepository
            .getPaginated(galleryItems!.first, false, count: 21)
        : await storage.galleryItemRepository.getWithSearch(
            widget.searchOptions!, galleryItems!.first, false,
            count: 21);
    setState(() {
      galleryItems = items;
    });
  }

  String createSearchString(Search search) {
    var withTagsString = search.withTags.map((e) => e.toString()).join("+");
    var withoutTagsString =
        search.withoutTags.map((e) => e.toString()).join("+");
    var sinceString = search.since != null
        ? DateFormat.yMMMd(Localizations.localeOf(context).toString())
            .format(search.since!)
        : "";
    var untilString = search.until != null
        ? DateFormat.yMMMd(Localizations.localeOf(context).toString())
            .format(search.until!)
        : "";

    var searchString = "";
    if (withTagsString.isNotEmpty) {
      searchString += "($withTagsString)";
    }
    if (withoutTagsString.isNotEmpty) {
      searchString += "-($withoutTagsString)";
    }
    if (sinceString.isNotEmpty) {
      searchString += " ${AppLocalizations.of(context)!.since}$sinceString";
    }
    if (untilString.isNotEmpty) {
      searchString += " ${AppLocalizations.of(context)!.until}$untilString";
    }
    return searchString;
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
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: AppColors.primaryPure,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                child: Text(
                                  createSearchString(widget.searchOptions!),
                                  style: TextStyles.button.copyWith(
                                      color: AppColors.neutralDarker,
                                      overflow: TextOverflow.ellipsis),
                                )),
                            const Icon(Icons.search,
                                color: AppColors.neutralDarker, size: 24)
                          ],
                        ))),
            Padding(
                padding: const EdgeInsets.all(6),
                child: MainScreenPopup(refresh))
          ],
        ),
        backgroundColor: AppColors.baseLight,
        body: galleryItems != null
            ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: hasItems
                    ? Provider.value(
                        value: galleryItems,
                        child: ImageGrid(
                          galleryItems: galleryItems!,
                          onSearch: widget.searchOptions != null,
                          advancePage: advancePage,
                          goBackPage: goBackPage,
                        ))
                    : Center(
                        child: Text(
                          AppLocalizations.of(context)!.addToGalleryMessage,
                          style: TextStyles.h1
                              .copyWith(color: AppColors.neutralDarker),
                          textAlign: TextAlign.center,
                        ),
                      ))
            : FutureBuilder<List<GalleryItem>>(
                future: getItemsFirstTime(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {
                        galleryItems = snapshot.data!;
                      });
                    });
                    return const SizedBox.shrink();
                  } else if (widget.searchOptions != null) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.searching,
                        style: TextStyles.h1
                            .copyWith(color: AppColors.neutralDarker),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (!hasItems) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.addToGalleryMessage,
                        style: TextStyles.h1
                            .copyWith(color: AppColors.neutralDarker),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.updatingGallery,
                        style: TextStyles.h1
                            .copyWith(color: AppColors.neutralDarker),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              )

        // hasItems
        //     ? Padding(
        //         padding: const EdgeInsets.only(top: 15),
        //         child: Provider.value(
        //             value: galleryItems,
        //             child: ImageGrid(
        //               galleryItems: galleryItems,
        //               onSearch: widget.searchOptions != null,
        //               advancePage: advancePage,
        //               goBackPage: goBackPage,
        //             )))
        //     : Center(
        //         child: Text(
        //           AppLocalizations.of(context)!.addToGalleryMessage,
        //           style: TextStyles.h1.copyWith(color: AppColors.neutralDarker),
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        );
  }
}
