import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

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
        // telabuscaELX (7:45)
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupqyqbCAs (MR6UKXRZLmvwc5rChiQyQb)
              padding:
                  EdgeInsets.fromLTRB(18 * fem, 28 * fem, 22 * fem, 28 * fem),
              width: double.infinity,
              height: 104 * fem,
              decoration: const BoxDecoration(
                color: Color(0xffe1bee7),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupmfod6n3 (MR6UVGeKYTup2PSsiNmfoD)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 21.5 * fem, 0 * fem),
                    width: 48 * fem,
                    height: 48 * fem,
                    child: Image.asset(
                      'assets/page-1/images/auto-group-mfod.png',
                      width: 48 * fem,
                      height: 48 * fem,
                    ),
                  ),
                  Container(
                    // buscaRJX (7:62)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 76.5 * fem, 0 * fem),
                    child: Text(
                      'Busca',
                      textAlign: TextAlign.center,
                      style: safeGoogleFont(
                        'Roboto',
                        fontSize: 28 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.3571428571 * ffem / fem,
                        letterSpacing: 0.4199999869 * fem,
                        color: const Color(0xff01013b),
                      ),
                    ),
                  ),
                  Container(
                    // autogroupvcymiYX (MR6UZrM29hkMf6SKVJVcyM)
                    width: 124 * fem,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffe040fb),
                      borderRadius: BorderRadius.circular(26 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'BUSCAR',
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
            Container(
              // autogroupj67qo4B (MR6UnGA1S5R54cHS3Nj67q)
              padding:
                  EdgeInsets.fromLTRB(18 * fem, 13 * fem, 18 * fem, 319 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff5f5f5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // contendoastagsVxb (7:63)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 3 * fem),
                    width: double.infinity,
                    child: Text(
                      'Contendo as tags:',
                      textAlign: TextAlign.center,
                      style: safeGoogleFont(
                        'Roboto',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5833333333 * ffem / fem,
                        letterSpacing: 0.6000000238 * fem,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // autogroupdkfvzuM (MR6V4b2941zsMXZNz2DKFV)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 210 * fem, 38 * fem),
                    width: double.infinity,
                    height: 32 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupp3bv7yy (MR6VBqK4jwXFySoGJMp3BV)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 6 * fem, 0 * fem),
                          width: 124 * fem,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffe0e0e0),
                            borderRadius: BorderRadius.circular(16 * fem),
                          ),
                          child: Container(
                            // group1eDD (7:74)
                            padding: EdgeInsets.fromLTRB(
                                13.5 * fem, 5 * fem, 15 * fem, 5 * fem),
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xfff3e5f5),
                              borderRadius: BorderRadius.circular(16 * fem),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroupgnztk1M (MR6VHL9uUE8K8hBoEGgNzT)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 14.5 * fem, 0 * fem),
                                  width: 59 * fem,
                                  height: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // naturezaUCF (7:67)
                                        left: 0 * fem,
                                        top: 0 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 59 * fem,
                                            height: 22 * fem,
                                            child: Text(
                                              'natureza',
                                              textAlign: TextAlign.center,
                                              style: safeGoogleFont(
                                                'Roboto',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.5714285714 * ffem / fem,
                                                letterSpacing:
                                                    0.4199999869 * fem,
                                                color: const Color(0xfff3e5f5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // naturezaxNK (19:53)
                                        left: 0 * fem,
                                        top: 0 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 59 * fem,
                                            height: 22 * fem,
                                            child: Text(
                                              'natureza',
                                              textAlign: TextAlign.center,
                                              style: safeGoogleFont(
                                                'Roboto',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.5714285714 * ffem / fem,
                                                letterSpacing:
                                                    0.4199999869 * fem,
                                                color: const Color(0xff012856),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // icbaselinecloseRmh (7:68)
                                  width: 22 * fem,
                                  height: 22 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/ic-baseline-close-WJK.png',
                                    width: 22 * fem,
                                    height: 22 * fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // icbaselineplusZd1 (7:64)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: 14 * fem,
                          height: 14 * fem,
                          child: Image.asset(
                            'assets/page-1/images/ic-baseline-plus-y5Z.png',
                            width: 14 * fem,
                            height: 14 * fem,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // nocontendoastagsfg3 (7:70)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 3 * fem),
                    width: double.infinity,
                    child: Text(
                      'Não contendo as tags:',
                      textAlign: TextAlign.center,
                      style: safeGoogleFont(
                        'Roboto',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5833333333 * ffem / fem,
                        letterSpacing: 0.6000000238 * fem,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // autogroupvqd9A71 (MR6VWaGqbBwrULVB1nVqd9)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 215 * fem, 42 * fem),
                    width: double.infinity,
                    height: 32 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // group2t31 (7:75)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 11 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              14 * fem, 5 * fem, 19.58 * fem, 5 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xfff3e5f5),
                            borderRadius: BorderRadius.circular(16 * fem),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // pessoaPEf (7:77)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 19.58 * fem, 0 * fem),
                                child: Text(
                                  'pessoa',
                                  textAlign: TextAlign.center,
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
                                // icbaselineclose695 (7:78)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                width: 12.83 * fem,
                                height: 12.83 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/ic-baseline-close-Mrw.png',
                                  width: 12.83 * fem,
                                  height: 12.83 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // icbaselineplusbbd (7:84)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: 14 * fem,
                          height: 14 * fem,
                          child: Image.asset(
                            'assets/page-1/images/ic-baseline-plus.png',
                            width: 14 * fem,
                            height: 14 * fem,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // rectangle12igF (7:90)
                    margin: EdgeInsets.fromLTRB(
                        25 * fem, 0 * fem, 26 * fem, 13 * fem),
                    width: double.infinity,
                    height: 3 * fem,
                    decoration: const BoxDecoration(
                      color: Color(0xffe1bee7),
                    ),
                  ),
                  Container(
                    // perodoSs9 (7:91)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 3 * fem),
                    child: Text(
                      'Período:',
                      style: safeGoogleFont(
                        'Roboto',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5833333333 * ffem / fem,
                        letterSpacing: 0.6000000238 * fem,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // autogroupj8s9Lhd (MR6VgEfQWRK3JE926uJ8s9)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 19 * fem, 13 * fem),
                    width: double.infinity,
                    height: 56 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // apartirdesSf (7:92)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 16 * fem, 0 * fem),
                          child: Text(
                            'A partir de:',
                            style: safeGoogleFont(
                              'Roboto',
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4545454545 * ffem / fem,
                              letterSpacing: 0.1452000058 * fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          // autogrouprfcbPA7 (MR6VnpJmvfuyAqpJ2tRfcB)
                          padding: EdgeInsets.fromLTRB(
                              176 * fem, 18 * fem, 16 * fem, 18 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffe0e0e0),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Align(
                            // icrounddaterangeJns (7:95)
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 18 * fem,
                              height: 20 * fem,
                              child: Image.asset(
                                'assets/page-1/images/ic-round-date-range-GQw.png',
                                width: 18 * fem,
                                height: 20 * fem,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupxc1dpmD (MR6VteUPnnykhjz8eyXc1d)
                    margin: EdgeInsets.fromLTRB(
                        4 * fem, 0 * fem, 19 * fem, 0 * fem),
                    width: double.infinity,
                    height: 56 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // atXvX (7:93)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 82 * fem, 0 * fem),
                          child: Text(
                            'Até:',
                            style: safeGoogleFont(
                              'Roboto',
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4545454545 * ffem / fem,
                              letterSpacing: 0.1452000058 * fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          // autogroupjjrwqwD (MR6Vzj8bWHtb1szT3hJjrw)
                          padding: EdgeInsets.fromLTRB(
                              176 * fem, 18 * fem, 16 * fem, 18 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffe0e0e0),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Align(
                            // icrounddaterangeNRM (7:101)
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 18 * fem,
                              height: 20 * fem,
                              child: Image.asset(
                                'assets/page-1/images/ic-round-date-range.png',
                                width: 18 * fem,
                                height: 20 * fem,
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
