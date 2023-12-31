import 'package:chips_input/chips_input.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taggy/utils/constants/app_colors.dart';
import 'package:taggy/utils/constants/text_styles.dart';
import 'package:taggy/entities/search.dart';
import 'package:taggy/entities/tag.dart';
import 'package:taggy/screens/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taggy/storage.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<GalleryStorageSQLite>()
        .tagRepository
        .getAll()
        .then((value) => setState(() => availableTags = value));
  }

  late Iterable<Tag> availableTags;
  List<Tag> withTags = [];
  List<Tag> withoutTags = [];
  DateTime? since;
  DateTime? until;
  TextEditingController dateUntilTextController = TextEditingController();
  TextEditingController dateSinceTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryMedium,
          foregroundColor: AppColors.neutralDark,
          iconTheme: const IconThemeData(color: AppColors.neutralDarker),
          title: Text(
            AppLocalizations.of(context)!.search,
            style: TextStyles.h2.copyWith(color: AppColors.neutralDarker),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6, right: 22),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryPure),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26)))),
                    onPressed: () {
                      var options = Search(withTags, withoutTags, since, until);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainScreen(
                          searchOptions: options,
                        ),
                      ));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.search.toUpperCase(),
                      style: TextStyles.button
                          .copyWith(color: AppColors.neutralDarker),
                    )))
          ],
        ),
        body: ListView(padding: const EdgeInsets.all(11), children: [
          Text(
            AppLocalizations.of(context)!.withTags,
            style: TextStyles.h3.copyWith(color: AppColors.neutralDark),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: ChipsInput(
                decoration: const InputDecoration(
                    suffixIcon: Icon(
                  Icons.add,
                  color: AppColors.neutralDark,
                  size: 24,
                )),
                onChanged: (tags) {
                  withTags = tags;
                },
                findSuggestions: (String query) => availableTags
                    .where((element) =>
                        !withoutTags.contains(element) &&
                        element.description
                            .toLowerCase()
                            .startsWith(query.toLowerCase()))
                    .toList(),
                chipBuilder: (context, state, data) {
                  return InputChip(
                      deleteIcon:
                          const Icon(Icons.close, color: AppColors.neutralDark),
                      onDeleted: () => state.deleteChip(data),
                      backgroundColor: AppColors.primaryLight,
                      label: Text(data.description,
                          style: TextStyles.subtitle2
                              .copyWith(color: AppColors.neutralDark)));
                },
                suggestionBuilder: (context, tag) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    title: Text(tag.description,
                        style: TextStyles.subtitle1
                            .copyWith(color: AppColors.neutralDarker)),
                  );
                },
              )),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.withoutTags,
            style: TextStyles.h3.copyWith(color: AppColors.neutralDark),
          ),
          ChipsInput(
            decoration: const InputDecoration(
                suffixIcon: Icon(
              Icons.add,
              color: AppColors.neutralDark,
              size: 24,
            )),
            onChanged: (tags) {
              withoutTags = tags;
            },
            findSuggestions: (String query) => availableTags
                .where((element) =>
                    !withTags.contains(element) &&
                    element.description
                        .toLowerCase()
                        .startsWith(query.toLowerCase()))
                .toList(),
            chipBuilder: (context, state, data) {
              return InputChip(
                  deleteIcon:
                      const Icon(Icons.close, color: AppColors.neutralDark),
                  onDeleted: () => state.deleteChip(data),
                  backgroundColor: AppColors.primaryLight,
                  label: Text(data.description,
                      style: TextStyles.subtitle2
                          .copyWith(color: AppColors.neutralDark)));
            },
            suggestionBuilder: (context, tag) {
              return ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text(tag.description,
                    style: TextStyles.subtitle1
                        .copyWith(color: AppColors.neutralDarker)),
              );
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 3,
                color: AppColors.primaryMedium,
              ))),
          Text(
            AppLocalizations.of(context)!.dateRange,
            style: TextStyles.h3.copyWith(color: AppColors.neutralDarker),
          ),
          const SizedBox(height: 15),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.3),
              1: FractionColumnWidth(0.7)
            },
            children: [
              TableRow(children: [
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(AppLocalizations.of(context)!.since,
                        style: TextStyles.h4
                            .copyWith(color: AppColors.neutralDarker))),
                Row(
                  children: [
                    Flexible(
                        child: DateTimeField(
                      controller: dateSinceTextController,
                      onChanged: (value) {
                        if (value != null) {
                          since = DateUtils.dateOnly(value);
                        } else {
                          since = value;
                        }
                      },
                      resetIcon: null,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          fillColor: AppColors.baseMedium,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: AppColors.neutralDark,
                          ),
                          contentPadding: EdgeInsets.all(10)),
                      style: TextStyles.subtitle1
                          .copyWith(color: AppColors.neutralDark),
                      format: DateFormat.yMMMd(
                          Localizations.localeOf(context).toString()),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            firstDate: DateTime.fromMillisecondsSinceEpoch(0,
                                isUtc: true),
                            lastDate: DateTime(DateTime.now().year + 100),
                            context: context,
                            initialDate: currentValue ?? DateTime.now());
                      },
                    )),
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: dateSinceTextController.clear,
                        icon: const Icon(
                          Icons.clear,
                          color: AppColors.neutralDarker,
                          size: 24,
                        ))
                  ],
                )
              ]),
              const TableRow(children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
              ]),
              TableRow(children: [
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(AppLocalizations.of(context)!.until,
                        style: TextStyles.h4
                            .copyWith(color: AppColors.neutralDarker))),
                Row(
                  children: [
                    Flexible(
                        child: DateTimeField(
                      controller: dateUntilTextController,
                      onChanged: (value) {
                        if (value != null) {
                          until = DateUtils.dateOnly(value)
                              .add(const Duration(days: 1, milliseconds: -1));
                        } else {
                          until = value;
                        }
                      },
                      resetIcon: null,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          fillColor: AppColors.baseMedium,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: AppColors.neutralDark,
                          ),
                          contentPadding: EdgeInsets.all(10)),
                      style: TextStyles.subtitle1
                          .copyWith(color: AppColors.neutralDark),
                      format: DateFormat.yMMMd(
                          Localizations.localeOf(context).toString()),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            firstDate: DateTime.fromMillisecondsSinceEpoch(0,
                                isUtc: true),
                            lastDate: DateTime(DateTime.now().year + 100),
                            context: context,
                            initialDate: currentValue ?? DateTime.now());
                      },
                    )),
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: dateUntilTextController.clear,
                        icon: const Icon(
                          Icons.clear,
                          color: AppColors.neutralDarker,
                          size: 24,
                        ))
                  ],
                )
              ])
            ],
          )
        ]));
  }
}
