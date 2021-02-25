import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

const url = "http://fim.amaty.biz/api";
const img = "http://fim.amaty.biz/uploads";
const simil = "http://fim.amaty.biz/api/similaire";
const fim_url = "https://www.fimguinee.com";
const thumbnail = "https://img.youtube.com/vi";
const fmStream = "http://live02.rfi.fr/rfimonde-96k.mp3";

const faceBook = "https://www.facebook.com/fimguinee";

String fbId;

const twitter = "https://www.twitter.com/fimguinee";
const insta = "https://www.instagram.com/fimguinee";
const youtube = "";



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
                      's\'abonner',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            FlatButton(
              color: Colors.blue[600],
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
              onPressed: () => _launchSocial(twitter),
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
              onPressed: () => null,
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
  );
}
