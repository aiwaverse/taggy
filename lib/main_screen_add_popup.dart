import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:taggy/constants/text_styles.dart';

import 'constants/app_colors.dart';

enum AddOptions { files, folders }

class AddPopup extends StatefulWidget {
  const AddPopup({super.key, required this.addFolder, required this.addImages});

  final Future<void> Function(String) addFolder;
  final void Function(List<String>) addImages;

  @override
  State<StatefulWidget> createState() => _AddPopupState();
}

class _AddPopupState extends State<AddPopup> {
  AddOptions? selectedScreen;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AddOptions>(
      tooltip: "Adicionar",
      initialValue: selectedScreen,
      offset: const Offset(0, 40),
      onSelected: (AddOptions option) async {
        switch (option) {
          case AddOptions.files:
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null) {
              List<String> paths = result.files
                  .map((plataformFile) => plataformFile.path)
                  .whereType<String>()
                  .toList();
              widget.addImages(paths);
            }
          case AddOptions.folders:
            String? result = await FilePicker.platform
                .getDirectoryPath(lockParentWindow: true);
            if (result != null) {
              await widget.addFolder(result);
            }
        }
      },
      itemBuilder: ((context) => [
            const PopupMenuItem(
              value: AddOptions.files,
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Imagens",
                    style: TextStyles.body1,
                  )
                ],
              ),
            ),
            const PopupMenuItem(
              value: AddOptions.folders,
              child: Row(
                children: [
                  Icon(
                    Icons.folder,
                    color: AppColors.neutralDarker,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Pastas",
                    style: TextStyles.body1,
                  )
                ],
              ),
            ),
          ]),
      child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.primaryPure),
          child: const Icon(Icons.add, size: 24.0)),
    );
  }
}
