import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  Future<void> _launched;

  goToFim( String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return Center(
        child: Text("Problème d'accès au site Fim"),
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

  Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
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
                teamCarousel(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _launched = _launchUniversalLinkIos('https://www.fimguinee.com');
                    });
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
                          Icon(MaterialCommunityIcons.apple_safari, size: 22, color: Colors.white,),
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

Widget teamCarousel() {
  return Column(
    children: [
      CarouselSlider(
        items: [
          items(
              "Malick Cissé",
              "presentateur de l'emission 'la terre inconnue'",
              'assets/croissant.jpg'),
          items("Fanta Keita", "presentateur de l'emission 'la terre inconnue'",
              'assets/omelette.jpg'),
          items(
              "Mariama Diallo",
              "presentateur de l'emission 'la terre inconnue'",
              'assets/fataya.jpg'),
        ],
        options: CarouselOptions(
          height: 470,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(
            milliseconds: 200,
          ),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 0.8,
        ),
      ),
    ],
  );
}

Widget items(
  String name,
  String presentation,
  String img,
) {
  return Container(
    height: 520,
    width: 420,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 420,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  img,
                ),
              )),
          // child: Image.asset(
          //   ,
          //   fit: BoxFit.cover,
          // ),
        ),
        Column(
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            child: Text(
              presentation,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
