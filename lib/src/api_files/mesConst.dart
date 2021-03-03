import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

const url = "https://fimguinee.com/api/home";
const img = "https://fimguinee.com/uploads";
const simil = "https://fimguinee.com/api/similaire";
const fim_url = "https://www.fimguinee.com/accueil";
const share_url = "https://www.fimguinee.com/actualite";
const thumbnail = "https://img.youtube.com/vi";
const fmStream = "http://fimstreaming.zentechnologies.net:8000/fimlive";

const faceBook = "https://www.facebook.com/fimguinee";

String fbId;

const twitter = "https://www.twitter.com/fimguinee";
const insta = "https://www.instagram.com/fimguinee";
const youtube = "https://m.youtube.com/channel/UCzyeperNyib1C_a6PiDmKug";



void _launchSocial(String url) async {
  try {
    bool launched = await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
    if (!launched) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  } catch (e) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  }
}

void _launchFB(String url, String backUrl) async {
  try {
    bool launched = await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
    if (!launched) {
      await launch(
        backUrl,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  } catch (e) {
    await launch(
      backUrl,
      forceSafariVC: false,
      forceWebView: false,
    );
  }
}

Widget reseauSociaux() {
Platform.isIOS ? fbId = "fb://profile/116943413560577" : fbId ="fb://page/116943413560577";
  return Container(
    height: 130,
    child: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              color: Colors.blue[800],
              onPressed: () =>  _launchFB(fbId, faceBook),
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
                      'FaceBook',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            FlatButton(
              color: Color(0xFF833AB4),
              onPressed: () => _launchSocial(insta),
              child: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Zocial.instagram,
                      color: Colors.white,
                    ),
                    Text(
                      'Instagram',
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
              onPressed: () => _launchSocial(twitter),
              child: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Zocial.twitter,
                      color: Colors.white,
                      size:18,
                    ),
                    Text(
                      'Twitter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            FlatButton(
              color: Colors.red[600],
              onPressed: () => _launchSocial(youtube),
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
                      'Youtube',
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
  );
}

 Future<void> share(dynamic link, String title) async {
    await FlutterShare.share(
      title: "Fim Guinée",
      text: title,
      linkUrl: link,
      chooserTitle: "Partager cet article à vos proches",
    );
  }