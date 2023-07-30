import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';

class ImageDetail extends StatefulWidget {
  const ImageDetail({super.key, required this.imageFile});
  final GalleryItem imageFile;
  @override
  State<StatefulWidget> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  void addTag(String newTag) {
    setState(() {
      if (!widget.imageFile.tags.contains(Tag(newTag))) {
        widget.imageFile.tags.add(Tag(newTag));
      }
    });
  }

  void removeTag(Tag tag) {
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
                      image: widget.imageFile.image.image,
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
                                widget.imageFile.fileName,
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
                          Text(
                            "Data: ${DateFormat("dd/MM/yyyy").format(widget.imageFile.lastModified)}",
                            style: TextStyles.subtitle1
                                .copyWith(color: AppColors.neutralDark),
                          )
                        ])),
                    Row(children: [
                      IconButton(
                          onPressed: () {},
                          tooltip: "Compartilhar",
                          icon: const Icon(
                            Icons.share,
                            color: AppColors.neutralDark,
                          )),
                      IconButton(
                          onPressed: () {},
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
              padding: const EdgeInsets.only(left: 16),
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
                                    title: const Text("Adicionar tag"),
                                    content: TextField(
                                      textInputAction: TextInputAction.done,
                                      onChanged: (value) => content = value,
                                      onSubmitted: (value) {
                                        if (value.isNotEmpty == true) {
                                          addTag(value);
                                        }
                                        Navigator.pop(context);
                                      },
                                    ),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancelar",
                                              style: TextStyles.button.copyWith(
                                                  color:
                                                      AppColors.neutralDark))),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (content?.isNotEmpty == true) {
                                              addTag(content!);
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Ok",
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
                          child: Text("ADICIONAR TAG",
                              style: TextStyles.button.copyWith(
                                  color: AppColors.neutralDarker)))))),
          ...widget.imageFile.tags.map((tag) => Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(16),
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
                                  tag.value,
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
                                  onPressed: () => removeTag(tag),
                                ))
                          ])))))
        ]));
  }
}
