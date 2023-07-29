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
        // telaresultadobuscazY7 (7:107)
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupkm6fX2F (MR6SPq8foQvWxTEBj4Km6F)
              padding:
                  EdgeInsets.fromLTRB(18 * fem, 27 * fem, 18 * fem, 28 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffe1bee7),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupgsy5qHq (MR6SaQfNqh4DJtH7yAGSy5)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 1 * fem, 0 * fem, 0 * fem),
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/auto-group-gsy5.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Container(
                    // autogroupkchmvq5 (MR6SejsVbZ3iAMS5yTKChM)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 1 * fem),
                    padding: EdgeInsets.fromLTRB(
                        13 * fem, 15 * fem, 17.51 * fem, 14.51 * fem),
                    decoration: BoxDecoration(
                      color: const Color(0xffe040fb),
                      borderRadius: BorderRadius.circular(26 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // naturezapessoaQkF (7:127)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 29 * fem, 0.49 * fem),
                          child: Text(
                            '(natureza) - (pessoa)',
                            style: safeGoogleFont(
                              'Roboto',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2857142857 * ffem / fem,
                              letterSpacing: 1.3999999762 * fem,
                              color: const Color(0xff01013b),
                            ),
                          ),
                        ),
                        Container(
                          // icbaselinesearchgBy (7:114)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 1 * fem, 0 * fem, 0 * fem),
                          width: 17.49 * fem,
                          height: 17.49 * fem,
                          child: Image.asset(
                            'assets/page-1/images/ic-baseline-search-psh.png',
                            width: 17.49 * fem,
                            height: 17.49 * fem,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Container(
                    // autogroupr96oa2T (MR6Ska37Tg7VhFbvbYR96o)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 1 * fem, 0 * fem, 0 * fem),
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/auto-group-r96o.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroup32rvV9R (MR6SwQ4QML6EpvVLcH32RV)
              padding:
                  EdgeInsets.fromLTRB(8 * fem, 11 * fem, 8 * fem, 542 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff5f5f5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // imagensencontradas1QXH (7:129)
                    margin: EdgeInsets.fromLTRB(
                        10 * fem, 0 * fem, 0 * fem, 11 * fem),
                    child: Text(
                      'Imagens encontradas: 1',
                      style: safeGoogleFont(
                        'Roboto',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * ffem / fem,
                        letterSpacing: 0.400000006 * fem,
                        color: const Color(0xff01013b),
                      ),
                    ),
                  ),
                  SizedBox(
                    // autogroupuneti2B (MR6T2tuF5chHzAssYBuNET)
                    width: 166 * fem,
                    height: 152 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // forestbackgroundr8P (24:15)
                          left: 10 * fem,
                          top: 9 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 156 * fem,
                              height: 136 * fem,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: Image.asset(
                                  'assets/page-1/images/forest-background-52F.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // rectangle3wvX (7:125)
                          left: 0 * fem,
                          top: 0 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 161 * fem,
                              height: 152 * fem,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffd9d9d9),
                                ),
                              ),
                            ),
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
