import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({super.key, required this.gallery});
  final Gallery gallery;

  @override
  State<StatefulWidget> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  Widget build(BuildContext context) {
    var foundImages = widget.gallery.items.length;
    return Column(
      children: [
        foundImages > 0
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Total de imagens encontradas: $foundImages",
                  style: TextStyles.subtitle1,
                ))
            : const SizedBox.shrink(),
        LazyLoadScrollView(
            onEndOfPage: () {},
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              runAlignment: WrapAlignment.start,
              children: [
                for (var item in widget.gallery.items)
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: item.image.image)),
                  )
              ],
            ))
      ],
    );
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