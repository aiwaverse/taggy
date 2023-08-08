import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taggy/entities/tag.dart';
import 'package:taggy/entities/gallery_item.dart';
import 'package:taggy/storage.dart';

class ImageDetail extends StatefulWidget {
  const ImageDetail({super.key, required this.imageFile});
  final GalleryItem imageFile;
  @override
  State<StatefulWidget> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  late GalleryStorageSQLite storage;
  @override
  void initState() {
    super.initState();
    storage = context.read<GalleryStorageSQLite>();
  }

  Future<void> addTag(String description) async {
    description = description.trim();
    var tag = Tag(description);
    if (widget.imageFile.tags.contains(tag)) {
      return;
    }
    await storage.tagRepository.insert(tag);
    await storage.galleryItemTagRepository
        .addTagToImage(widget.imageFile.id!, tag);
    var tags = await storage.galleryItemTagRepository
        .getTagsFromImage(widget.imageFile);
    setState(() {
      widget.imageFile.tags = tags;
    });
  }

  Future<void> removeTag(Tag tag) async {
    await storage.galleryItemTagRepository
        .delete(widget.imageFile.id!, tag.id!);
    setState(() {
      widget.imageFile.tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryMedium,
          foregroundColor: AppColors.neutralDark,
          iconTheme: const IconThemeData(color: AppColors.neutralDarker),
        ),
        body: ListView(padding: const EdgeInsets.all(11), children: [
          Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Image(
                      image: widget.imageFile.image,
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.contain))),
          Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SelectableText(
                                widget.imageFile.name,
                                style: TextStyles.h4.copyWith(
                                  color: AppColors.neutralDark,
                                  overflow: TextOverflow.ellipsis,
                                  //softWrap: false,
                                ),
                                maxLines: 1,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Tooltip(
                              message: AppLocalizations.of(context)!.whatDate,
                              child: Text(
                                "${AppLocalizations.of(context)!.date}: ${DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(widget.imageFile.date)}",
                                style: TextStyles.subtitle1
                                    .copyWith(color: AppColors.neutralDark),
                              ))
                        ])),
                    Row(children: [
                      IconButton(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: Platform.isWindows || Platform.isLinux
                              ? null
                              : () {
                                  Share.shareXFiles(
                                      [XFile(widget.imageFile.path)]);
                                },
                          tooltip: Platform.isWindows || Platform.isLinux
                              ? AppLocalizations.of(context)!.shareUnavaliable
                              : AppLocalizations.of(context)!.share,
                          icon: Icon(
                            Icons.share,
                            color: Platform.isWindows || Platform.isLinux
                                ? Theme.of(context).disabledColor
                                : AppColors.neutralDark,
                          )),
                      IconButton(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () async {
                            await OpenFile.open(widget.imageFile.path);
                          },
                          tooltip: AppLocalizations.of(context)!.openExternally,
                          icon: const Icon(Icons.open_in_new,
                              color: AppColors.neutralDark))
                    ])
                  ])),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 3,
                color: AppColors.primaryMedium,
              ))),
          Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 150,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  String? content;
                                  return AlertDialog(
                                    title: Text(
                                        AppLocalizations.of(context)!.addTag),
                                    content: TextField(
                                      textInputAction: TextInputAction.done,
                                      onChanged: (value) => content = value,
                                      onSubmitted: (value) async {
                                        if (value.isNotEmpty == true) {
                                          await addTag(value);
                                        }
                                        if (!context.mounted) {
                                          return;
                                        }
                                        Navigator.pop(context);
                                      },
                                    ),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .cancel,
                                              style: TextStyles.button.copyWith(
                                                  color:
                                                      AppColors.neutralDark))),
                                      ElevatedButton(
                                          onPressed: () async {
                                            if (content?.isNotEmpty == true) {
                                              await addTag(content!);
                                            }
                                            if (!context.mounted) {
                                              return;
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.ok,
                                            style: TextStyles.button,
                                          ))
                                    ],
                                  );
                                });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.primaryPure),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(26)))),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .addTag
                                  .toUpperCase(),
                              style: TextStyles.button.copyWith(
                                  color: AppColors.neutralDarker)))))),
          ...widget.imageFile.tags.map((tag) => Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: AppColors.primaryLight),
                      height: 32,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  tag.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyles.subtitle2
                                      .copyWith(color: AppColors.neutralDark),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  icon: const Icon(Icons.close),
                                  color: AppColors.neutralDark,
                                  iconSize: 24,
                                  onPressed: () async => await removeTag(tag),
                                ))
                          ])))))
        ]));
  }
}
