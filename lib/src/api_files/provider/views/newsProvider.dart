import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../details/articleDetails.dart';
import '../../details/journalTV.dart';
import '../../mesConst.dart';
import '../models/dataModel.dart';
import '../fimProvider.dart';

class NewsProvider extends StatefulWidget {
  @override
  _NewsProviderState createState() => _NewsProviderState();
}

class _NewsProviderState extends State<NewsProvider>
    with AutomaticKeepAliveClientMixin {
  Future<void> _launched;

  urlLauncher() {
    setState(() {
      _launched = _launchUniversalLinkIos('$fim_url');
    });
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  double elevation = 5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<FimProvider>(
          builder: (_, FimProvider fimProvider, __) {
            if (fimProvider.fimModel.sliders.isEmpty) {
              return Center(
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
              );
            } else if (fimProvider.fimModel.sliders.isNotEmpty) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 250,
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(10.0),
                      child: Swiper(
                        fade: 0.0,
                        itemBuilder: (BuildContext context, int index) {
                          Other sliders = fimProvider.fimModel.sliders[index];
                          return Column(
                            children: <Widget>[
                              Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    color: Colors.blueGrey,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '$img/${sliders.image}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.orange.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Flexible(
                                                child: Text(
                                                  sliders.titre,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )),
                            ],
                          );
                        },
                        onTap: (index) {
                          Other sliders = fimProvider.fimModel.sliders[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SliderDetails(
                                  id: sliders.id,
                                  titre: sliders.titre,
                                  subtitle: sliders.categorie['nom'],
                                  image: '$img/' + sliders.image,
                                  description: sliders.description,
                                );
                              },
                            ),
                          );
                        },
                        duration: 1,
                        autoplay: true,
                        itemCount: fimProvider.fimModel.sliders.length,
                        scale: 0.9,
                        pagination: SwiperPagination(),
                      ),
                    ),
                  ),
                  // Actualités recentes
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 5,
                            color: Colors.orange[900],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Actualités recentes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  AnimationLimiter(
                    child: SliverGrid.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        fimProvider.fimModel.recents.length,
                        (int index) {
                          Other recents = fimProvider.fimModel.recents[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SliderDetails(
                                          id: recents.id,
                                          titre: recents.titre,
                                          subtitle: recents.categorie['nom'],
                                          image: '$img/' + recents.image,
                                          description: recents.description,
                                        );
                                      },
                                    ),
                                  ),
                                  child: Card(
                                    elevation: elevation,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 220,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 150,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Image.network(
                                                  '$img/' + '${recents.image}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  child: Text(
                                                    "${recents.titre}",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          right: -5,
                                          child: Container(
                                            height: 20,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.orange[900],
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Center(
                                              child: Text(
                                                recents.categorie['nom'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Dernières vidéos
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           height: 40,
                  //           width: 5,
                  //           color: Colors.orange[900],
                  //         ),
                  //         SizedBox(
                  //           width: 20,
                  //         ),
                  //         Text(
                  //           "Dernières vidéos",
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // AnimationLimiter(
                  //   child: SliverGrid.count(
                  //     crossAxisCount: 2,
                  //     children: List.generate(
                  //       fimProvider.fimModel.videos.length,
                  //       (int index) {
                  //         Video videos = fimProvider.fimModel.videos[index];
                  //         return AnimationConfiguration.staggeredGrid(
                  //           position: index,
                  //           duration: const Duration(milliseconds: 375),
                  //           columnCount: 2,
                  //           child: ScaleAnimation(
                  //             child: FadeInAnimation(
                  //               child: InkWell(
                  //                 onTap: () {
                  //                   Navigator.push(context,
                  //                       MaterialPageRoute(builder: (context) {
                  //                     return JournalTV(
                  //                       url: videos.url,
                  //                     );
                  //                   }));
                  //                 },
                  //                 child: Card(
                  //                   elevation: elevation,
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Stack(
                  //                         children: [
                  //                           Container(
                  //                             height: 155,
                  //                             width: MediaQuery.of(context)
                  //                                     .size
                  //                                     .width /
                  //                                 2,
                  //                             decoration: BoxDecoration(
                  //                               color: Colors.grey[700],
                  //                               image: DecorationImage(
                  //                                 fit: BoxFit.fill,
                  //                                 image: NetworkImage(
                  //                                   '$thumbnail/${YoutubePlayer.convertUrlToId(videos.url)}/0.jpg',
                  //                                 ),
                  //                               ),
                  //                               borderRadius:
                  //                                   BorderRadius.circular(5),
                  //                             ),
                  //                             child: Icon(
                  //                               Icons.play_arrow,
                  //                               color: Colors.orange[900],
                  //                               size: 60,
                  //                             ),
                  //                           ),
                  //                           Positioned(
                  //                             top: 20,
                  //                             right: -5,
                  //                             child: Container(
                  //                               height: 20,
                  //                               width: 120,
                  //                               decoration: BoxDecoration(
                  //                                 color: Colors.orange[900],
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(7),
                  //                               ),
                  //                               child: Center(
                  //                                 child: Text(
                  //                                   videos.titre,
                  //                                   style: TextStyle(
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(10),
                  //                         child: Text(
                  //                           videos.type,
                  //                           style: TextStyle(
                  //                             fontSize: 18,
                  //                           ),
                  //                           maxLines: 1,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // // Les plus populaires
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 5,
                            color: Colors.orange[900],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Les plus populaires",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimationLimiter(
                    child: SliverGrid.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        fimProvider.fimModel.populaires.length,
                        (int index) {
                          Other populaires =
                              fimProvider.fimModel.populaires[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SliderDetails(
                                      id: populaires.id,
                                      titre: populaires.titre,
                                      subtitle: populaires.categorie['nom'],
                                      image: '$img/' + populaires.image,
                                      description: populaires.description,
                                      slug: populaires.slug,
                                    );
                                  })),
                                  child: Card(
                                    elevation: elevation,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 220,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 150,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Image.network(
                                                  '$img/' +
                                                      '${populaires.image}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  child: Text(
                                                    "${populaires.titre}",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          right: -5,
                                          child: Container(
                                            height: 20,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.orange[900],
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Center(
                                              child: Text(
                                                populaires.categorie['nom'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Les réseaux sociaux
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 5,
                            color: Colors.orange[900],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Nos réseaux sociaux",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: reseauSociaux(),
                  ),
                  // Plus d'actualités
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            checkConn();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100),
                            child: Container(
                              height: 40,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.orange[700],
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return SpinKitFadingCube(
                color: Colors.orange[900],
              );
            }
          },
        ),
      ),
    );
  }
}
