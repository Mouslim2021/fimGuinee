import 'package:fim_guinee/src/api_files/comments/recentComment.dart';
import 'package:flutter/material.dart';

import '../mesConst.dart';

class SimOthersDetail extends StatefulWidget {
  int id;
  String titre;
  String subtitle;
  String image;
  String description;

  SimOthersDetail({
    this.id,
    this.titre,
    this.subtitle,
    this.image,
    this.description,
  });
  @override
  _SimOthersDetailState createState() => _SimOthersDetailState();
}

class _SimOthersDetailState extends State<SimOthersDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return RecentComment(
                      id: widget.id,
                    );
                  })),
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
              child: reseauSociaux(),
              ),
          ],
        ),
      ),
    );
  }
}
