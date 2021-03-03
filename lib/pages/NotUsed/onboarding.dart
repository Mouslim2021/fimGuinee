import 'package:fim_guinee/navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => NavyBarPage(),),
      (route)  => false
      );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    pageDecoration(Color color) {
      return PageDecoration(
        titleTextStyle:
            const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: color,
        imagePadding: EdgeInsets.zero,
      );
    }

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            titleWidget: Text(
              'FIM 24 GUINEE',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            decoration: pageDecoration(Colors.orange[500]),
            bodyWidget: Card(
              child: Container(
                width: 350,
                height: 580,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.event_note,
                      size: 200,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'FIM MEDIA',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              'Toute l\'actualité à portée de main',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'FIM 24 GUINEE',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            decoration: pageDecoration(Colors.orange[700]),
            bodyWidget: Card(
              child: Container(
                width: 350,
                height: 580,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.live_tv,
                      size: 200,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'FIM24 live TV',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              'Régardez tous nos programme en direct',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'FIM 24 GUINEE',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            bodyWidget: Card(
              child: Container(
                width: 350,
                height: 580,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.radio,
                      size: 200,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'FIM24 FM',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              'Ecoutez nos émissions partout dans le monde',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            footer: RaisedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(0);
              },
              child: const Text(
                'Revoir',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            decoration: pageDecoration(Colors.orange[900]),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text(
          'Sauter',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        done: const Text(
          'Terminé',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}

