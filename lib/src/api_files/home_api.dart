import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:progress_indicator_button/button_stagger_animation.dart';
import 'package:progress_indicator_button/progress_button.dart';



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


class ButtonStaggerAnimation extends StatelessWidget {
  // Animation fields
  final AnimationController controller;

  // Display fields
  final Color color;
  final Color progressIndicatorColor;
  final double progressIndicatorSize;
  final BorderRadius borderRadius;
  final double strokeWidth;
  final Function(AnimationController) onPressed;
  final Widget child;

  ButtonStaggerAnimation({
    Key key,
    this.controller,
    this.color,
    this.progressIndicatorColor,
    this.progressIndicatorSize,
    this.borderRadius,
    this.onPressed,
    this.strokeWidth,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _progressAnimatedBuilder);
  }

  Widget _buttonChild() {
    if (controller.isAnimating) {
      return Container();
    } else if (controller.isCompleted) {
      return OverflowBox(
        maxWidth: progressIndicatorSize,
        maxHeight: progressIndicatorSize,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(progressIndicatorColor),
        ),
      );
    }
    return child;
  }

  AnimatedBuilder _progressAnimatedBuilder(
      BuildContext context, BoxConstraints constraints) {
    var buttonHeight = (constraints.maxHeight != double.infinity)
        ? constraints.maxHeight
        : 60.0;

    var widthAnimation = Tween<double>(
      begin: constraints.maxWidth,
      end: buttonHeight,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    var borderRadiusAnimation = Tween<BorderRadius>(
      begin: borderRadius,
      end: BorderRadius.all(Radius.circular(buttonHeight / 2.0)),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SizedBox(
          height: buttonHeight,
          width: widthAnimation.value,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadiusAnimation.value,
            ),
            color: color,
            child: _buttonChild(),
            onPressed: () {
              this.onPressed(controller);
            },
          ),
        );
      },
    );
  }
}