import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:taggy/entities/managable.dart';
import 'package:taggy/repositories/irepository.dart';
import 'package:taggy/utils/constants/app_colors.dart';
import 'package:taggy/utils/constants/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManagementScreen<T> extends StatefulWidget {
  const ManagementScreen(this.repository, this.refresh,
      {super.key, required this.title});
  final IRepository<T> repository;
  final String title;
  final Future<void> Function() refresh;
  @override
  State<StatefulWidget> createState() => _ManagementScreenState<T>();
}

class _ManagementScreenState<T> extends State<ManagementScreen> {
  List<Managable> items = [];
  String searchFor = "";
  @override
  void initState() {
    super.initState();
    widget.repository
        .getAll()
        .then((value) => setState(() => items = value as List<Managable>));
  }

  Future<void> refresh() async {
    var repoItems = await widget.repository.getAll() as List<Managable>;
    setState(() {
      items = repoItems;
    });
  }

  Future<void> edit(Managable item) async {
    String? content;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                "${AppLocalizations.of(context)!.edit} ${item.shortInfo}",
                style: TextStyles.h5.copyWith(color: AppColors.neutralDarker),
                textAlign: TextAlign.center,
              ),
              content: TextField(
                decoration: InputDecoration(hintText: item.shortInfo),
                textInputAction: TextInputAction.done,
                onChanged: (value) => content = value,
                onSubmitted: (value) {
                  if (value.isNotEmpty == true) {
                    widget.repository
                        .update(item.alterForUpdate(value))
                        .whenComplete(widget.refresh)
                        .whenComplete(refresh)
                        .whenComplete(() => Navigator.pop(context));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              actions: [
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel,
                        style: TextStyles.button
                            .copyWith(color: AppColors.neutralDark))),
                ElevatedButton(
                    onPressed: () {
                      if (content?.isNotEmpty == true) {
                        widget.repository
                            .update(item.alterForUpdate(content!))
                            .whenComplete(widget.refresh)
                            .whenComplete(refresh)
                            .whenComplete(() => Navigator.pop(context));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.ok,
                      style: TextStyles.button,
                    ))
              ]);
        });
  }

  Future<void> delete(Managable item) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //contentPadding: const EdgeInsets.all(15),
            title: Text(
              item.shortInfo,
              style: TextStyles.h5.copyWith(color: AppColors.neutralDarker),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    item.completeInfo,
                    style: TextStyles.subtitle1
                        .copyWith(color: AppColors.neutralDarker),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  item.getWarning(context),
                  style: TextStyles.h2.copyWith(color: AppColors.neutralDarker),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: [
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancel,
                      style: TextStyles.button
                          .copyWith(color: AppColors.neutralDark))),
              ElevatedButton(
                  onPressed: () {
                    widget.repository
                        .delete(item)
                        .whenComplete(refresh)
                        .whenComplete(widget.refresh)
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.remove,
                    style: TextStyles.button,
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EasySearchBar(
          onSearch: (searchTerm) => setState(() => searchFor = searchTerm),
          backgroundColor: AppColors.primaryMedium,
          foregroundColor: AppColors.neutralDark,
          iconTheme: const IconThemeData(color: AppColors.neutralDarker),
          searchBackIconTheme:
              const IconThemeData(color: AppColors.neutralDarker),
          searchClearIconTheme:
              const IconThemeData(color: AppColors.neutralDarker),
          searchCursorColor: AppColors.neutralDarker,
          searchTextStyle:
              TextStyles.body1.copyWith(color: AppColors.neutralDarker),
          searchBackgroundColor: AppColors.baseLight,
          title: Text(
            widget.title,
            style: TextStyles.h2.copyWith(color: AppColors.neutralDark),
          ),
        ),
        backgroundColor: AppColors.baseLight,
        body: ListView(children: [
          const SizedBox(height: 10),
          ...items
              .where((element) => element.completeInfo
                  .toLowerCase()
                  .contains(searchFor.toLowerCase()))
              .map((item) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: AppColors.primaryLight),
                    child: Row(children: [
                      Text(
                        item.shortInfo,
                        style: TextStyles.subtitle2
                            .copyWith(color: AppColors.neutralDark),
                      ),
                      const Spacer(),
                      IconButton(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: item.updateable
                              ? () async => await edit(item)
                              : null,
                          icon: Icon(
                            Icons.edit,
                            color: item.updateable
                                ? AppColors.neutralDarker
                                : Theme.of(context).disabledColor,
                          )),
                      IconButton(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: item.deletable
                              ? () async => await delete(item)
                              : null,
                          icon: Icon(
                            Icons.delete,
                            color: item.deletable
                                ? AppColors.neutralDarker
                                : Theme.of(context).disabledColor,
                          ))
                    ]),
                  )))
              .toList()
        ]));
  }
}
