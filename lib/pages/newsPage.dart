import 'dart:convert';

import 'package:fim_guinee/src/api_files/details/recentsDetails.dart';
import 'package:fim_guinee/src/api_files/details/populairesDetails.dart';
import 'package:fim_guinee/src/api_files/details/othersDetails.dart';
import 'package:fim_guinee/src/api_files/details/journalTV.dart';
import 'package:fim_guinee/src/api_files/mesConst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with WidgetsBindingObserver {

  double elevation = 5;

  getSlidersImg() async {
    final response = await http.get("$url/home");
    final result = json.decode(response.body);
    // Map<String, dynamic> data = jsonDecode(response.body);
    return result;
  }

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
        body: FutureBuilder(
          future: getSlidersImg(),
          builder: (context, snapShot) {
            if (snapShot.hasError) {
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
            } else if (snapShot.hasData) {
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
                                      '$img/${snapShot.data['sliders'][index]['image']}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Flexible(
                                      child: Text(
                                        snapShot.data['sliders'][index]
                                            ['titre'],
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
                        
                        onTap: (index) {},
                        duration: 1,
                        autoplay: true,
                        itemCount: snapShot.data.length - 1,
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
                        snapShot.data['recents'].length,
                        (int index) {
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
                                          id: snapShot.data['recents'][index]
                                              ['id'],
                                          titre: snapShot.data['recents'][index]
                                              ['titre'],
                                          subtitle: snapShot.data['recents']
                                              [index]['categorie']['nom'],
                                          image: '$img/' +
                                              snapShot.data['recents'][index]
                                                  ['image'],
                                          description: snapShot.data['recents']
                                              [index]['description'],
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
                                                    '${snapShot.data['recents'][index]['image']}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Container(
                                                  child: Text(
                                                    "${snapShot.data['recents'][index]['titre']}",
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
                                                snapShot.data['recents'][index]
                                                    ['categorie']['nom'],
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
                        snapShot.data['videos'].length,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return JournalTV(
                                      url: snapShot.data['videos'][index]
                                          ['url'],
                                    );
                                  })),
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
                                                color: Colors.red,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                    'assets/journal.jpg',
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                                                    snapShot.data['videos']
                                                        [index]['titre'],
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
                                            snapShot.data['videos'][index]
                                                ['type'],
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
                        snapShot.data['populaires'].length,
                        (int index) {
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
                                      id: snapShot.data['populaires'][index]
                                          ['id'],
                                      titre: snapShot.data['populaires'][index]
                                          ['titre'],
                                      subtitle: snapShot.data['populaires']
                                          [index]['categorie']['nom'],
                                      image: '$img/' +
                                          snapShot.data['populaires'][index]
                                              ['image'],
                                      description: snapShot.data['populaires']
                                          [index]['description'],
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
                                                    '${snapShot.data['populaires'][index]['image']}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Container(
                                                  child: Text(
                                                    "${snapShot.data['populaires'][index]['titre']}",
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
                                                snapShot.data['populaires']
                                                    [index]['categorie']['nom'],
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
                        snapShot.data['others'].length,
                        (int index) {
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
                                      id: snapShot.data['others'][index]['id'],
                                      titre: snapShot.data['others'][index]
                                          ['titre'],
                                      subtitle: snapShot.data['others'][index]
                                          ['categorie']['nom'],
                                      image: '$img/' +
                                          snapShot.data['others'][index]
                                              ['image'],
                                      description: snapShot.data['others']
                                          [index]['description'],
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
                                                    '${snapShot.data['others'][index]['image']}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Container(
                                                  child: Text(
                                                    "${snapShot.data['others'][index]['titre']}",
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
                                                snapShot.data['others'][index]
                                                    ['categorie']['nom'],
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
