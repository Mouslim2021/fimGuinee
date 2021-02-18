import 'dart:convert';

import 'package:fim_guinee/src/api_files/details/recentsDetails.dart';
import 'package:fim_guinee/src/api_files/details/populairesDetails.dart';
import 'package:fim_guinee/src/api_files/details/othersDetails.dart';
import 'package:fim_guinee/src/api_files/details/journalTV.dart';
import 'package:fim_guinee/src/api_files/details/slidersDetails.dart';
import 'package:fim_guinee/src/api_files/mesConst.dart';
import 'package:fim_guinee/src/api_files/provider/fimProvider.dart';
import 'package:fim_guinee/src/api_files/provider/models/dataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsProvider extends StatefulWidget {
  @override
  _NewsProviderState createState() => _NewsProviderState();
}

class _NewsProviderState extends State<NewsProvider>
    with WidgetsBindingObserver {

  double elevation = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<FimProvider>(
          builder: (_, FimProvider fimProvider, __) {
            if (fimProvider.fimModel.sliders.isEmpty) {
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Flexible(
                                      child: Text(
                                        sliders.titre,
                                        style: TextStyle(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.5),
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                          image: '$img/' +sliders.image,
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
                                        return RecentDetails(
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
                                                child: Image.network('$img/' +
                                                    '${recents.image}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
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
                  SliverToBoxAdapter(
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
                          "Dernières vidéos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimationLimiter(
                    child: SliverGrid.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        fimProvider.fimModel.videos.length,
                        (int index) {
                          Video videos = fimProvider.fimModel.videos[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return JournalTV(
                                      url: videos.url,
                                    );
                                  }));
                                  },
                                  child: Card(
                                    elevation: elevation,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 155,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[700],
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    '$thumbnail/${YoutubePlayer.convertUrlToId(videos.url)}/0.jpg',
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: Colors.orange[900],
                                                size: 60,
                                                ),
                                            ),
                                            Positioned(
                                              top: 20,
                                              right: -5,
                                              child: Container(
                                                height: 20,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange[900],
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    videos.titre,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            videos.type,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            maxLines: 1,
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
                  // Les plus populaires
                  SliverToBoxAdapter(
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
                                    return PopulaireDetails(
                                      id: populaires.id,
                                      titre: populaires.titre,
                                      subtitle: populaires.categorie['nom'],
                                      image: '$img/' + populaires.image,
                                      description: populaires.description,
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
                                                child: Image.network('$img/' +
                                                    '${populaires.image}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
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
                  SliverToBoxAdapter(
                    child: Container(
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
                  ),
                  // Plus d'actualités
                  SliverToBoxAdapter(
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
                          "Plus d'actualités",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimationLimiter(
                    child: SliverGrid.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        fimProvider.fimModel.others.length,
                        (int index) {
                          Other others = fimProvider.fimModel.others[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return OthersDetails(
                                      id: others.id,
                                      titre: others.titre,
                                      subtitle: others.categorie['nom'],
                                      image: '$img/' + others.image,
                                      description: others.description,
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
                                                child: Image.network('$img/' +
                                                    '${others.image}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Container(
                                                  child: Text(
                                                    "${others.titre}",
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
                                                others.categorie['nom'],
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
