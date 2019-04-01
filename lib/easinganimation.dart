import 'package:flutter/material.dart';

class EasingAnimation extends StatefulWidget{
  @override
  _EasingAnimationState createState() => _EasingAnimationState();
}

class _EasingAnimationState extends State<EasingAnimation> with TickerProviderStateMixin{

  Animation animation;

  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: animationController
      )
    )..addStatusListener((status){
      if(status == AnimationStatus.completed){
        animationController.reset();
        animation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            curve: Curves.fastOutSlowIn,
            parent: animationController
          )
        )..addStatusListener((status){
          if(status == AnimationStatus.completed){
            Navigator.of(context).pop();
          }
        });
        animationController.forward();
      }
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context){

    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Easing Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child){
            return Transform(
              transform: Matrix4.translationValues(animation.value * deviceWidth, 0.0, 0.0),
              child: Container(
                height: 100.0,
                width: 100.0,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
      )
    );
  }
}