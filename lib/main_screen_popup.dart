import 'package:flutter/material.dart';
import 'package:taggy/constants/text_styles.dart';

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
      tooltip: "Mais opções",
      initialValue: selectedScreen,
      offset: const Offset(0, 40),
      onSelected: (MenuScreen screen) {},
      itemBuilder: ((context) => [
            const PopupMenuItem(
              value: MenuScreen.files,
              child: Row(
                children: [
                  Icon(
                    Icons.folder,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Arquivos",
                    style: TextStyles.body1,
                  )
                ],
              ),
            ),
            const PopupMenuItem(
              value: MenuScreen.files,
              child: Row(
                children: [
                  Icon(
                    Icons.tag,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Tags",
                    style: TextStyles.body1,
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
          child: Icon(Icons.more_vert, size: 24.0),
        ),
      ),
    );
  }
}
