import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:snake_game/homepage.dart';
import 'package:snake_game/main.dart';


 class IntroScreen extends StatefulWidget {
   const IntroScreen({ Key? key }) : super(key: key);
 
   @override
   IntroScreenState createState() => IntroScreenState();
 }
 
 class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "HOW TO PLAY",
        description: "Use hand gestures for navigation",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "GAME OVER RULES",
        description: "Game gets over when you touch yourself",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "BUGS",
        description:
            "Sometimes snake moves on it own and score becomes 0, in such state please exit and start the game",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MainPage()),
  );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}