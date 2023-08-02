import 'package:chips_input/chips_input.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';
import 'package:taggy/entities/search.dart';
import 'package:taggy/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.avaliableTags});
  final Iterable<Tag> avaliableTags;
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Tag> withTags = [];
  List<Tag> withoutTags = [];
  DateTime? since;
  DateTime? until;
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
                findSuggestions: (String query) => widget.avaliableTags
                    .where((element) =>
                        !withoutTags.contains(element) &&
                        element.value
                            .toLowerCase()
                            .startsWith(query.toLowerCase()))
                    .toList(),
                chipBuilder: (context, state, data) {
                  return InputChip(
                      deleteIcon:
                          const Icon(Icons.close, color: AppColors.neutralDark),
                      onDeleted: () => state.deleteChip(data),
                      backgroundColor: AppColors.primaryLight,
                      label: Text(data.value,
                          style: TextStyles.subtitle2
                              .copyWith(color: AppColors.neutralDark)));
                },
                suggestionBuilder: (context, tag) {
                  // TODO: Make this pretty
                  return ListTile(
                    title: Text(tag.value,
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
            findSuggestions: (String query) => widget.avaliableTags
                .where((element) =>
                    !withTags.contains(element) &&
                    element.value.toLowerCase().startsWith(query.toLowerCase()))
                .toList(),
            chipBuilder: (context, state, data) {
              return InputChip(
                  deleteIcon:
                      const Icon(Icons.close, color: AppColors.neutralDark),
                  onDeleted: () => state.deleteChip(data),
                  backgroundColor: AppColors.primaryLight,
                  label: Text(data.value,
                      style: TextStyles.subtitle2
                          .copyWith(color: AppColors.neutralDark)));
            },
            suggestionBuilder: (context, tag) {
              // TODO: Make this pretty
              return ListTile(
                title: Text(tag.value,
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
          GridView.count(
            crossAxisCount: 2,
            //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(AppLocalizations.of(context)!.since,
                      style: TextStyles.h4
                          .copyWith(color: AppColors.neutralDarker))),
              Align(
                  alignment: Alignment.topRight,
                  child: DateTimeField(
                    onChanged: (value) {
                      since = value;
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        fillColor: AppColors.baseMedium,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        suffixIcon: Icon(
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(AppLocalizations.of(context)!.until,
                    style:
                        TextStyles.h4.copyWith(color: AppColors.neutralDarker)),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: DateTimeField(
                    onChanged: (value) {
                      until = value;
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        fillColor: AppColors.baseMedium,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        suffixIcon: Icon(
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
            ],
          )
        ]));
  }
}
