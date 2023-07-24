import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class Scene extends StatelessWidget {
  const Scene({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 138;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // popupmenu95q (5:7)
        padding: EdgeInsets.fromLTRB(16 * fem, 17 * fem, 24 * fem, 20 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xfff3e5f5),
          borderRadius: BorderRadius.circular(8 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // group10eoH (40:32)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 9 * fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // folder9k3 (7:31)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 8 * fem, 3 * fem),
                        width: 24 * fem,
                        height: 24 * fem,
                        child: Image.asset(
                          'assets/page-1/images/folder-Nu5.png',
                          width: 24 * fem,
                          height: 24 * fem,
                        ),
                      ),
                      Container(
                        // arquivosfiP (7:34)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 3 * fem, 0 * fem, 0 * fem),
                        child: Text(
                          'Arquivos',
                          style: safeGoogleFont(
                            'Roboto',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                            letterSpacing: 0.400000006 * fem,
                            color: const Color(0xff012856),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // group11Af9 (40:34)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 29 * fem, 0 * fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding:
                      EdgeInsets.fromLTRB(4 * fem, 3 * fem, 0 * fem, 0 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // icbaselinetageKR (7:36)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 12 * fem, 6 * fem),
                        width: 16 * fem,
                        height: 16 * fem,
                        child: Image.asset(
                          'assets/page-1/images/ic-baseline-tag.png',
                          width: 16 * fem,
                          height: 16 * fem,
                        ),
                      ),
                      Text(
                        // tagsLxw (7:38)
                        'Tags',
                        style: safeGoogleFont(
                          'Roboto',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * ffem / fem,
                          letterSpacing: 0.400000006 * fem,
                          color: const Color(0xff012856),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
