import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taggy/utils/constants/app_colors.dart';
import 'package:taggy/utils/constants/text_styles.dart';
import 'package:taggy/entities/gallery_item.dart';
import 'package:taggy/screens/image_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid(
      {super.key,
      required this.galleryItems,
      required this.onSearch,
      required this.advancePage,
      required this.goBackPage});
  final List<GalleryItem> galleryItems;
  final bool onSearch;
  final Future<void> Function() advancePage;
  final Future<void> Function() goBackPage;

  @override
  State<StatefulWidget> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  var scrollController = ScrollController();
  var page = 1;
  static const int imagesPerPage = 20;

  Future<void> advancePage() async {
    page++;
    scrollController.jumpTo(0);
    await widget.advancePage();
  }

  Future<void> goBackPage() async {
    page--;
    scrollController.jumpTo(0);
    await widget.goBackPage();
  }

  @override
  Widget build(BuildContext context) {
    var items = context.watch<List<GalleryItem>>();
    bool canAdvance = items.length > imagesPerPage;
    bool canGoBack = page >= 2;
    return Center(
        child: Column(
      children: [
        widget.onSearch
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  AppLocalizations.of(context)!.searchResults,
                  style: TextStyles.subtitle1
                      .copyWith(color: AppColors.neutralDarker),
                ))
            : const SizedBox.shrink(),
        Expanded(
            child: SingleChildScrollView(
                controller: scrollController,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  runAlignment: WrapAlignment.start,
                  children: [
                    for (var item in items.sublist(
                        0, items.length > 20 ? 20 : items.length))
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ImageDetail(imageFile: item))),
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    filterQuality: FilterQuality.medium,
                                    fit: BoxFit.cover,
                                    image: item.image)),
                          ))
                  ],
                ))),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: canGoBack ? () async => await goBackPage() : null,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              color: AppColors.neutralDark,
            ),
            const SizedBox(width: 8),
            Text(page.toString(),
                style: TextStyles.subtitle1
                    .copyWith(color: AppColors.neutralDark)),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: canAdvance ? () async => await advancePage() : null,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              color: AppColors.neutralDark,
            )
          ],
        ))
      ],
    ));
  }
}
