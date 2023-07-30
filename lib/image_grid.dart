import 'package:flutter/material.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({super.key, required this.gallery});
  final Gallery gallery;

  @override
  State<StatefulWidget> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  int page = 1;
  final int imagesPerPage = 20;
  var scrollController = ScrollController();
  void advancedPage() {
    setState(() {
      if (widget.gallery.items.length >= (page * imagesPerPage + 1)) {
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
    var foundImages = widget.gallery.items.length;
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
                    for (var item in widget.gallery.items.sublist(start, end))
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: item.image.image)),
                      )
                  ],
                ))),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: backPage,
            ),
            const SizedBox(width: 8),
            // TODO: Find a better way to align text with the icons
            Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(page.toString(), style: TextStyles.subtitle1)),
            const SizedBox(width: 8),
            IconButton(
                onPressed: advancedPage, icon: const Icon(Icons.arrow_forward))
          ],
        ))
      ],
    ));
  }
}


// Wrap(
//             spacing: 8.0,
//             runSpacing: 4.0,
//             runAlignment: WrapAlignment.start,
//             children: [
//               for (var item in widget.gallery.items)
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             fit: BoxFit.fitWidth,
//                             alignment: FractionalOffset.topCenter,
//                             image: item.image.image)),
//                   ),
//                 )
//             ]),