import 'package:flutter/material.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants/app_colors.dart';

enum MenuScreen { files, tags }

class MainScreenPopup extends StatefulWidget {
  const MainScreenPopup({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenPopupState();
}

class _MainScreenPopupState extends State<MainScreenPopup> {
  MenuScreen? selectedScreen;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuScreen>(
      tooltip: AppLocalizations.of(context)!.moreOptions,
      initialValue: selectedScreen,
      offset: const Offset(0, 40),
      onSelected: (MenuScreen screen) {},
      itemBuilder: ((context) => [
            PopupMenuItem(
              value: MenuScreen.files,
              child: Row(
                children: [
                  const Icon(
                    Icons.folder,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.files,
                    style: TextStyles.body1
                        .copyWith(color: AppColors.neutralDarker),
                  )
                ],
              ),
            ),
            PopupMenuItem(
              value: MenuScreen.files,
              child: Row(
                children: [
                  const Icon(
                    Icons.tag,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.tags,
                    style: TextStyles.body1
                        .copyWith(color: AppColors.neutralDarker),
                  )
                ],
              ),
            ),
          ]),
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primaryPure),
        child: const Padding(
          padding: EdgeInsets.all(11.0),
          child:
              Icon(Icons.more_vert, size: 24.0, color: AppColors.neutralDarker),
        ),
      ),
    );
  }
}
