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
        // telatagsbGj (36:81)
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroup7zipCQw (MR6LE6F5zWZZdGFPh67ZiP)
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
                    // autogrouprflkfZR (MR6LR5vmT5mfwm2TYurFLK)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 28 * fem, 0 * fem),
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/auto-group-rflk.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                  Container(
                    // tagsm6f (36:88)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 121 * fem, 0 * fem),
                    child: Text(
                      'Tags',
                      textAlign: TextAlign.center,
                      style: safeGoogleFont(
                        'Roboto',
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.4545454545 * ffem / fem,
                        letterSpacing: 0.1452000058 * fem,
                        color: const Color(0xff01013b),
                      ),
                    ),
                  ),
                  Container(
                    // group12Ptj (40:54)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 12 * fem, 0 * fem),
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/group-12-njZ.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                  SizedBox(
                    // group13Hz7 (40:58)
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/group-13.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupbmu9pz3 (MR6LZFMqG44a6DfS2EbMu9)
              padding:
                  EdgeInsets.fromLTRB(18 * fem, 14 * fem, 12 * fem, 652 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff5f5f5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // group7wHy (36:107)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 10 * fem),
                    padding: EdgeInsets.fromLTRB(
                        12 * fem, 5 * fem, 14.58 * fem, 5 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xfff3e5f5),
                      borderRadius: BorderRadius.circular(16 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // rvorecf1 (36:109)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 253.75 * fem, 0 * fem),
                          child: Text(
                            'árvore',
                            style: safeGoogleFont(
                              'Roboto',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5714285714 * ffem / fem,
                              letterSpacing: 0.4199999869 * fem,
                              color: const Color(0xff012856),
                            ),
                          ),
                        ),
                        Container(
                          // mdipencilk8w (38:123)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 7.33 * fem, 0 * fem),
                          width: 16.5 * fem,
                          height: 16.5 * fem,
                          child: Image.asset(
                            'assets/page-1/images/mdi-pencil.png',
                            width: 16.5 * fem,
                            height: 16.5 * fem,
                          ),
                        ),
                        Container(
                          // icbaselinecloseSXZ (38:125)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: 12.83 * fem,
                          height: 12.83 * fem,
                          child: Image.asset(
                            'assets/page-1/images/ic-baseline-close.png',
                            width: 12.83 * fem,
                            height: 12.83 * fem,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group7MPd (36:112)
                    padding: EdgeInsets.fromLTRB(
                        12 * fem, 5 * fem, 14.58 * fem, 5 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xfff3e5f5),
                      borderRadius: BorderRadius.circular(16 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // naturezaFzo (36:114)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 237.75 * fem, 0 * fem),
                          child: Text(
                            'natureza',
                            style: safeGoogleFont(
                              'Roboto',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5714285714 * ffem / fem,
                              letterSpacing: 0.4199999869 * fem,
                              color: const Color(0xff012856),
                            ),
                          ),
                        ),
                        Container(
                          // mdipencilkAs (38:129)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 7.33 * fem, 0 * fem),
                          width: 16.5 * fem,
                          height: 16.5 * fem,
                          child: Image.asset(
                            'assets/page-1/images/mdi-pencil-Nhm.png',
                            width: 16.5 * fem,
                            height: 16.5 * fem,
                          ),
                        ),
                        Container(
                          // icbaselineclosef2w (38:131)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: 12.83 * fem,
                          height: 12.83 * fem,
                          child: Image.asset(
                            'assets/page-1/images/ic-baseline-close-o7V.png',
                            width: 12.83 * fem,
                            height: 12.83 * fem,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
