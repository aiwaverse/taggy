import 'package:flutter/material.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';
import 'package:taggy/image_detail.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({super.key, required this.galleryItems});
  final List<GalleryItem> galleryItems;

  @override
  State<StatefulWidget> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  int page = 1;
  final int imagesPerPage = 20;
  var scrollController = ScrollController();
  void advancedPage() {
    setState(() {
      if (widget.galleryItems.length >= (page * imagesPerPage + 1)) {
        page++;
        scrollController.jumpTo(0);
      }
    });
  }

  void backPage() {
    setState(() {
      if (page >= 2) {
        page--;
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
        foundImages > 0
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Total de imagens encontradas: $foundImages",
                  style: TextStyles.subtitle1,
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
                                    image: item.image.image)),
                          ))
                  ],
                ))),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: backPage,
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
              onPressed: advancedPage,
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
