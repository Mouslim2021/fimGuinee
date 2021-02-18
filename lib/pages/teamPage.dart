import 'dart:convert';

import 'package:fim_guinee/src/api_files/provider/fimProvider.dart';
import 'package:fim_guinee/src/api_files/provider/models/dataModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:fim_guinee/src/api_files/mesConst.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  Future<void> _launched;

  urlLauncher() {
    setState(() {
      _launched = _launchUniversalLinkIos('$fim_url');
    });
  }

    checkConn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      urlLauncher();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      urlLauncher();
    } else if (connectivityResult == ConnectivityResult.none) {
      showToast(
        'Aucune connexion détectée, Vérifiez votre internet et réessayez plus tard',
        context: context,
        animation: StyledToastAnimation.slideFromBottomFade,
        reverseAnimation: StyledToastAnimation.slideToBottomFade,
        position:
            StyledToastPosition(align: Alignment.bottomCenter, offset: 0.0),
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, -3.0),
        duration: Duration(seconds: 5),
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticInOut,
        reverseCurve: Curves.elasticOut,
      );
    }
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -65,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/teamBg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 130,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            color: Colors.blue[800],
                            onPressed: () {},
                            child: Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Zocial.facebook,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    's\'abonner',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          FlatButton(
                            color: Colors.blue[600],
                            onPressed: () {},
                            child: Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Zocial.linkedin,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    's\'abonner',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            color: Colors.blueAccent,
                            onPressed: () {},
                            child: Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Zocial.twitter,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    's\'abonner',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FlatButton(
                            color: Colors.red[600],
                            onPressed: () {},
                            child: Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Zocial.youtube,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    's\'abonner',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Consumer(builder: (_, FimProvider fimProvider, __){
                  if(fimProvider.fimModel.teams.isEmpty){
                    return Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          AntDesign.disconnect,
                          size: 150,
                          color: Colors.grey[800],
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 400,
                          child: Text(
                            "Erreur de recupération des news, vérifiez votre connexion puis réessayez",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SpinKitFadingCube(
                      duration: Duration(seconds: 5),
                      color: Colors.orange[900],
                    ),
                  ),
                ],
              );
                  } else if(fimProvider.fimModel.teams.isNotEmpty){
                    return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: fimProvider.fimModel.teams.length,
                          itemBuilder: (context, index) {
                            Team teams = fimProvider.fimModel.teams[index];
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                height: 360,
                                width: 340,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 380,
                                      width: 340,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            teams.image !=
                                                    null
                                                ? '$img/' + teams.image                                                    
                                                : "https://contentwriters.com/blog/wp-content/uploads/shutterstock_52238932-min-750x500.jpg",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          teams.name,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 24.0,
                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          child: Text(
                                            teams.fonction,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                  }
                }),
                GestureDetector(
                  onTap: () {
                    checkConn();
                  },
                  child: Container(
                    height: 40,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.orange[900],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MaterialCommunityIcons.apple_safari,
                            size: 22,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Visiter le site',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget teamCarousel({List myList}) {
//   return Column(
//     children: [
//       CarouselSlider(
//         items: [
//           ItemsList(
//             list: myList,
//           ),
//         ],
//         options: CarouselOptions(
//           height: 470,
//           aspectRatio: 16 / 9,
//           enlargeCenterPage: true,
//           enableInfiniteScroll: true,
//           autoPlayAnimationDuration: Duration(
//             milliseconds: 200,
//           ),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           viewportFraction: 0.8,
//         ),
//       ),
//     ],
//   );
// }

// Widget items(
//   String name,
//   String presentation,
//   String img,
// ) {
//   return Container(
//     height: 520,
//     width: 420,
//     decoration: BoxDecoration(
//       color: Colors.grey[200],
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: 300,
//           width: 420,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage(
//                 img,
//               ),
//             ),
//           ),
//         ),
//         Column(
//           children: [
//             Text(
//               name,
//               style: TextStyle(
//                 color: Colors.grey[800],
//                 fontSize: 24.0,
//               ),
//             ),
//           ],
//         ),
//         Flexible(
//           child: Container(
//             child: Text(
//               presentation,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey[800],
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// class ItemsList extends StatelessWidget {
//   List list;

//   ItemsList({
//     this.list,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: list.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(12),
//           child: Container(
//             height: 400,
//             width: 380,
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 300,
//                   width: 420,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(
//                         '$img/' + list[index]['image'],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       list[index]['name'],
//                       style: TextStyle(
//                         color: Colors.grey[800],
//                         fontSize: 24.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Flexible(
//                   child: Container(
//                     child: Text(
//                       list[index]['fonction'],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.grey[800],
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
