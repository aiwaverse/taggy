import 'package:flutter/material.dart';
import 'package:taggy/constants/app_colors.dart';
import 'package:taggy/constants/text_styles.dart';
import 'package:taggy/entities/gallery.dart';
import 'package:taggy/main_screen_add_popup.dart';

import 'image_grid.dart';
import 'main_screen_popup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Gallery gallery = Gallery();
  void addFolder(String folder) {
    setState(() {
      gallery.addFolder(folder);
    });
  }

  void addFiles(List<String> files) {
    setState(() {
      gallery.addFiles(files);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryMedium,
        foregroundColor: AppColors.neutralDark,
        leading: Padding(
            padding: const EdgeInsets.all(6),
            child: AddPopup(
              addFolder: addFolder,
              addImages: addFiles,
            )),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(6),
              child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPure,
                      shape: const CircleBorder(),
                      fixedSize: const Size(48, 48)),
                  child: const Icon(Icons.search,
                      color: AppColors.neutralDarker, size: 24))),
          const Padding(padding: EdgeInsets.all(6), child: MainScreenPopup())
        ],
      ),
      backgroundColor: AppColors.baseLight,
      body: gallery.isEmpty
          ? const Center(
              child: Text(
                "Clique no botão + para adicionar imagens e pastas a sua galeria.",
                style: TextStyles.h1,
              ),
            )
          : ImageGrid(
              gallery: gallery,
            ),
    );
    // double baseWidth = 390;
    // double fem = MediaQuery.of(context).size.width / baseWidth;
    // return SizedBox(
    //   width: double.infinity,
    //   child: Container(
    //     // telaprincipaldno (0:3)
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       color: const Color(0xfff5f5f5),
    //       borderRadius: BorderRadius.circular(20 * fem),
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Container(
    //           // autogroupkd99AXq (MR6QM4DF93d4sjFwH9kd99)
    //           padding:
    //               EdgeInsets.fromLTRB(18 * fem, 28 * fem, 18 * fem, 28 * fem),
    //           width: double.infinity,
    //           decoration: const BoxDecoration(
    //             color: Color(0xffe1bee7),
    //           ),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(
    //                 // autogroupwu6fVKD (MR6QYoNg9kNKXwYSSsWu6f)
    //                 margin: EdgeInsets.fromLTRB(
    //                     0 * fem, 0 * fem, 198 * fem, 0 * fem),
    //                 width: 48 * fem,
    //                 height: 48 * fem,
    //                 child: Image.asset(
    //                   'assets/page-1/images/auto-group-wu6f.png',
    //                   width: 48 * fem,
    //                   height: 48 * fem,
    //                 ),
    //               ),
    //               Container(
    //                 // autogroupsrxhCjR (MR6QcxvQLh8TCaokc5SrXh)
    //                 margin: EdgeInsets.fromLTRB(
    //                     0 * fem, 0 * fem, 12 * fem, 0 * fem),
    //                 width: 48 * fem,
    //                 height: 48 * fem,
    //                 child: Image.asset(
    //                   'assets/page-1/images/auto-group-srxh.png',
    //                   width: 48 * fem,
    //                   height: 48 * fem,
    //                 ),
    //               ),
    //               SizedBox(
    //                 // autogroup41qbixf (MR6QhNxiP1jdeTuYXv41Qb)
    //                 width: 48 * fem,
    //                 height: 48 * fem,
    //                 child: Image.asset(
    //                   'assets/page-1/images/auto-group-41qb.png',
    //                   width: 48 * fem,
    //                   height: 48 * fem,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           // autogroupftjh3zw (MR6QtCz1GfiNn8nxYeftjH)
    //           padding:
    //               EdgeInsets.fromLTRB(18 * fem, 20 * fem, 18 * fem, 199 * fem),
    //           width: double.infinity,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               SizedBox(
    //                 // autogrouppas1mvw (MR6R4NMjtemfAW7mB2pas1)
    //                 width: double.infinity,
    //                 height: 153 * fem,
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       // autogroupn87qKxT (MR6RA7hAUKDm6zLmsaN87q)
    //                       margin: EdgeInsets.fromLTRB(
    //                           0 * fem, 0 * fem, 32 * fem, 0 * fem),
    //                       width: 161 * fem,
    //                       height: double.infinity,
    //                       child: Align(
    //                         // forestbackgroundTHy (30:2)
    //                         alignment: Alignment.topLeft,
    //                         child: SizedBox(
    //                           width: 156 * fem,
    //                           height: 136 * fem,
    //                           child: TextButton(
    //                             onPressed: () {},
    //                             style: TextButton.styleFrom(
    //                               padding: EdgeInsets.zero,
    //                             ),
    //                             child: Image.asset(
    //                               'assets/page-1/images/forest-background-Ne3.png',
    //                               fit: BoxFit.contain,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       // autogroupw5omMeF (MR6RDs5vExuUoZsxR4W5om)
    //                       padding: EdgeInsets.fromLTRB(
    //                           5 * fem, 0 * fem, 0 * fem, 0 * fem),
    //                       height: double.infinity,
    //                       child: Align(
    //                         // beachbackgroundtu5 (30:4)
    //                         alignment: Alignment.topRight,
    //                         child: SizedBox(
    //                           width: 156 * fem,
    //                           height: 136 * fem,
    //                           child: Image.asset(
    //                             'assets/page-1/images/beach-background.png',
    //                             fit: BoxFit.contain,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 32 * fem,
    //               ),
    //               SizedBox(
    //                 // autogroupsd9hcaB (MR6RLn44o3y93qLY3DsD9H)
    //                 width: double.infinity,
    //                 height: 152 * fem,
    //               ),
    //               SizedBox(
    //                 height: 32 * fem,
    //               ),
    //               SizedBox(
    //                 // autogroupqkq7A5u (MR6RSXPVNiREzKZYjmQkQ7)
    //                 width: double.infinity,
    //                 height: 152 * fem,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
