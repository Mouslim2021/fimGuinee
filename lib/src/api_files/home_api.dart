import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class SwiperPage extends StatefulWidget {
  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 340,
            color: Colors.deepPurple,
            padding: EdgeInsets.all(16.0),
            child: Swiper(
              fade: 0.0,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          color: Colors.blueGrey,
                          image: DecorationImage(
                              image: NetworkImage(
                                "images[index]",
                              ),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        child: ListTile(
                          subtitle: Text('amazing application'),
                          title: Text('FlutterX UI'),
                        ))
                  ],
                );
              },
              itemCount: 10,
              scale: 0.9,
              // pagination : SwiperPagination(),
            ),
          ),
        ],
      ),
    );
  }
}
