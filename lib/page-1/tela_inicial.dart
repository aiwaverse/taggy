import 'package:flutter/material.dart';
import 'package:taggy/utils.dart';

class Scene extends StatelessWidget {
  const Scene({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // telainicialUN3 (7:12)
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroup13juPju (MR6TYt3HEpB3aoBKt513ju)
              padding:
                  EdgeInsets.fromLTRB(18 * fem, 28 * fem, 18 * fem, 28 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffe1bee7),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogrouprnhvK7m (MR6TeTiKFZPnLTWgjXRnhV)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 198 * fem, 0 * fem),
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/auto-group-rnhv.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                  Container(
                    // group12EVd (40:42)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 12 * fem, 0 * fem),
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/group-12-9V1.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                  SizedBox(
                    // group13Z27 (40:47)
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/group-13-7xK.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupt7zf6Gw (MR6Tkns6pS9fRqMUtst7zf)
              padding:
                  EdgeInsets.fromLTRB(32 * fem, 238 * fem, 32 * fem, 370 * fem),
              width: double.infinity,
              height: 740 * fem,
              decoration: const BoxDecoration(
                color: Color(0xfff5f5f5),
              ),
              child: Center(
                // useobotoparaadicionarpastasefo (7:40)
                child: SizedBox(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 326 * fem,
                    ),
                    child: Text(
                      'Use o botão + para adicionar pastas\ne fotos à sua galeria',
                      textAlign: TextAlign.center,
                      style: safeGoogleFont(
                        'Roboto',
                        fontSize: 34 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2941176471 * ffem / fem,
                        letterSpacing: 0.8500000238 * fem,
                        color: const Color(0xff01013b),
                      ),
                    ),
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
