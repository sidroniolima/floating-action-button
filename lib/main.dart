import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Action Button Animated',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animationMenuButton;
  Animation<double> animationOtherButtons;

  bool _isOpened = false;

  @override
  void initState() {
    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    animationMenuButton = CurveTween(curve: Curves.easeInOutBack).animate(animationController);
    animationOtherButtons = CurveTween(curve: Curves.elasticOut).animate(animationController);

    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset.fromDirection(270 * pi / 180, animationOtherButtons.value * 100),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(animationOtherButtons.value),
                      child: FloatedButtons(
                        icon: Icons.videocam,
                        color: Color(0xFF254441),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(-135 * pi / 180, animationOtherButtons.value * 100),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(animationOtherButtons.value),
                      child: FloatedButtons(
                        icon: Icons.map,
                        color: Color(0xFFEF3054),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(180 * pi / 180, animationOtherButtons.value * 100),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(animationOtherButtons.value),
                      child: FloatedButtons(
                        icon: Icons.person,
                        color: Color(0xFFb2b09b),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isOpened = !_isOpened;
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                      });
                    },
                    child: RotationTransition(
                      turns: animationMenuButton,
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFFff6f59)),
                        child: Icon(
                          Icons.menu,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FloatedButtons extends StatelessWidget {
  final IconData icon;
  final Color color;

  const FloatedButtons({
    Key key,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Icon(
        icon,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}