import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../mesConst.dart';
import '../detailSimilaires/simil_others_details.dart';

class OthersDetails extends StatefulWidget {
  int id;
  String titre;
  String subtitle;
  String image;
  String description;

  OthersDetails({
    this.id,
    this.titre,
    this.subtitle,
    this.image,
    this.description,
  });

  @override
  _OthersDetailsState createState() => _OthersDetailsState();
}

class _OthersDetailsState extends State<OthersDetails> {
  double elevation = 5;
  getDetails() async {
    final response = await http.get("$simil/${widget.id}");
    final result = json.decode(response.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getDetails(),
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
                        "Erreur de recupération des détails, vérifiez votre connexion puis réessayez",
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
                  // titre
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          widget.titre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // sous titre
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.book,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // image
                  SliverToBoxAdapter(
                    child: Container(
                      height: 380,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Description
                  SliverToBoxAdapter(
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(widget.description),
                      ),
                    ),
                  ),
                  // voir commentaires
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90),
                      child: FlatButton(
                        color: Colors.orange[900],
                        onPressed: () {},
                        child: Text(
                          'Voir les commentaires',
                          style: TextStyle(color: Colors.white),
                        ),
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
                  // articles similaires
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
                          "Articles similaires",
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
                        snapShot.data['similaires'].length,
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
                                    return SimOthersDetail(
                                      titre: snapShot.data['similaires'][index]
                                          ['titre'],
                                      subtitle: snapShot.data['similaires']
                                          [index]['categorie']['nom'],
                                      description: snapShot.data['similaires']
                                          [index]['description'],
                                      image: '$img/' +
                                          snapShot.data['similaires'][index]
                                              ['image'],
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
                                                    '${snapShot.data['similaires'][index]['image']}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Container(
                                                  child: Text(
                                                    "${snapShot.data['similaires'][index]['titre']}",
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
                                                snapShot.data['similaires']
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
