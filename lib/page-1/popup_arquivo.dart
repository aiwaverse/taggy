import 'package:flutter/material.dart';
import 'package:taggy/utils.dart';

class Scene extends StatelessWidget {
  const Scene({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 252;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // popuparquivoBkb (40:23)
        padding:
            EdgeInsets.fromLTRB(15.5 * fem, 22 * fem, 15.5 * fem, 22 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xfff3e5f5),
          borderRadius: BorderRadius.circular(8 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupeetz6cf (MR6ZQswRbyVbY3p8H9EETZ)
              margin:
                  EdgeInsets.fromLTRB(42.5 * fem, 0 * fem, 38 * fem, 3 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // icbaselineimageRew (40:26)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 8.5 * fem, 0 * fem),
                    width: 18 * fem,
                    height: 18 * fem,
                    child: Image.asset(
                      'assets/page-1/images/ic-baseline-image-QDM.png',
                      width: 18 * fem,
                      height: 18 * fem,
                    ),
                  ),
                  Text(
                    // florestajpgL1D (40:25)
                    'Floresta.jpg',
                    textAlign: TextAlign.center,
                    style: safeGoogleFont(
                      'Roboto',
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.5 * ffem / fem,
                      letterSpacing: 0.6000000238 * fem,
                      color: const Color(0xff01013b),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // mediasdfotosflorestajpgFP5 (40:28)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 25 * fem),
              child: Text(
                '/media/sd/fotos/Floresta.jpg',
                textAlign: TextAlign.center,
                style: safeGoogleFont(
                  'Roboto',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.5 * ffem / fem,
                  letterSpacing: 0.400000006 * fem,
                  color: const Color(0xff012856),
                ),
              ),
            ),
            Container(
              // autogrouplas1XbV (MR6ZWi73U6ZP4wyxuELAs1)
              margin:
                  EdgeInsets.fromLTRB(48.5 * fem, 0 * fem, 48.5 * fem, 0 * fem),
              width: double.infinity,
              height: 48 * fem,
              decoration: BoxDecoration(
                color: const Color(0xffe040fb),
                borderRadius: BorderRadius.circular(26 * fem),
              ),
              child: Center(
                child: Text(
                  'REMOVER',
                  style: safeGoogleFont(
                    'Roboto',
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2857142857 * ffem / fem,
                    letterSpacing: 1.3999999762 * fem,
                    color: const Color(0xff000000),
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
