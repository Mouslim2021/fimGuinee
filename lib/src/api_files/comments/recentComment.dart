import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mesConst.dart';

class RecentComment extends StatefulWidget {
  int id;

  RecentComment({
    this.id,
  });

  @override
  _RecentCommentState createState() => _RecentCommentState();
}

class _RecentCommentState extends State<RecentComment> {
  double elevation = 5;
  getComments() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.get("$simil/${widget.id}");
    // final result = json.decode();
    await preferences.setString('recentComment', response.body);
    final resultRecentComment = preferences.getString('recentComment');
    final result = json.decode(resultRecentComment);
    // print(result['commentaires']);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Les commentaires'),
        ),
        body: FutureBuilder(
          future: getComments(),
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
                        "Erreur de recupération des commentaires, vérifiez votre connexion puis réessayez",
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
              List list = snapShot.data['commentaires'];
              return list.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment,
                            size: 150,
                            color: Colors.grey[800],
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: 400,
                            child: Text(
                              "Aucun commentaire n'est disponible pour cet article",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 110,
                                width: 110,
                                child: CircleAvatar(
                                  backgroundColor: Colors.orange[900],
                                  child: Text(
                                    list[index]['name'][0],
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 320,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        list[index]['name'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 320,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          list[index]['contenu'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
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
