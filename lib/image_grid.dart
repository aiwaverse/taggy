import 'package:flutter/material.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery_item.dart';
import 'package:taggy/image_detail.dart';
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
  bool canAdvance() => widget.galleryItems.length > imagesPerPage;
  bool canGoBack() => page >= 2;

  void advancedPage() {
    setState(() {
      if (canAdvance()) {
        page++;
        widget.advancePage();
        scrollController.jumpTo(0);
      }
    });
  }

  void backPage() {
    setState(() {
      if (canGoBack()) {
        page--;
        widget.goBackPage();
        scrollController.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var foundImages = widget.galleryItems.length;
    var start = (page - 1) * imagesPerPage;
    var end = (start + imagesPerPage) < foundImages
        ? (start + imagesPerPage)
        : foundImages;
    return Center(
        child: Column(
      children: [
        widget.onSearch
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${AppLocalizations.of(context)!.imagesFound}: $foundImages",
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
                    for (var item in widget.galleryItems.sublist(start, end))
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
              onPressed: canGoBack() ? backPage : null,
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
              onPressed: canAdvance() ? advancedPage : null,
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
