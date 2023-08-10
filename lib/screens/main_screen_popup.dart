import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taggy/screens/managament_screen.dart';
import 'package:taggy/storage.dart';
import 'package:taggy/utils/constants/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants/app_colors.dart';

enum MenuScreen { folders, tags, images }

class MainScreenPopup extends StatefulWidget {
  const MainScreenPopup(this.refresh, {super.key});
  final Future<void> Function() refresh;
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
              value: MenuScreen.folders,
              child: Row(
                children: [
                  const Icon(
                    Icons.folder,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.folders,
                    style: TextStyles.body1
                        .copyWith(color: AppColors.neutralDarker),
                  )
                ],
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManagementScreen(
                      title: AppLocalizations.of(context)!.folders,
                      context.read<GalleryStorageSQLite>().directoryRepository,
                      widget.refresh))),
            ),
            PopupMenuItem(
              value: MenuScreen.images,
              child: Row(
                children: [
                  const Icon(
                    Icons.image,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.images,
                    style: TextStyles.body1
                        .copyWith(color: AppColors.neutralDarker),
                  )
                ],
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManagementScreen(
                      title: AppLocalizations.of(context)!.images,
                      context
                          .read<GalleryStorageSQLite>()
                          .galleryItemRepository,
                      widget.refresh))),
            ),
            PopupMenuItem(
              value: MenuScreen.tags,
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
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManagementScreen(
                      title: AppLocalizations.of(context)!.tags,
                      context.read<GalleryStorageSQLite>().tagRepository,
                      widget.refresh))),
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
