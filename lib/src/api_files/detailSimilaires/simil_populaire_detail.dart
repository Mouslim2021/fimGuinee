import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SimPopulDetail extends StatefulWidget {
  String titre;
  String subtitle;
  String image;
  String description;

  SimPopulDetail({
    this.titre,
    this.subtitle,
    this.image,
    this.description,
  });
  @override
  _SimPopulDetailState createState() => _SimPopulDetailState();
}

class _SimPopulDetailState extends State<SimPopulDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
      ),
    );
  }
}
