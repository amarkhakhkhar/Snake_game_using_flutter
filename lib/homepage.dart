import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:glassmorphism/glassmorphism.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  int numberOfSquares = 760;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(700);
  void generateNewFood() {
    food = randomNumber.nextInt(700);
  }

  void StartGame() {
    snakePosition = [45, 65, 85, 105, 125];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }

   var direction;
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last + 20 - 760);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;

        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add((snakePosition.last + 760 - 20));
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;

        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;

        default:
      }

      if (snakePosition.last == food || food > 700 || food < 40 || food % 18 == 0 || food % 19 == 0) {
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) count += 1;
      }
      if (count == 2) {
        return true;
      }
    }
    return false;
  }

  void _showGameOverScreen() {
    final popup = BeautifulPopup(
  context: context,
  template: TemplateFail,
);
popup.show(
  title: 'Game Over',
  content: 'Your score was: ' + snakePosition.length.toString(),
  actions: [
    popup.button(
      label: 'Close',
      onPressed: Navigator.of(context).pop,
    ),
    popup.button(
      label : "Quit",
      onPressed: (){SystemNavigator.pop();
      }
    )
  ],
  // bool barrierDismissible = false,
  // Widget close,
);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != 'up' && details.delta.dy > 0) {
                    direction = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    direction = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != 'left' && details.delta.dx > 0) {
                    direction = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    direction = 'left';
                  }
                },
                child : Container(
                  decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'images/bg2.jpg'),
                fit: BoxFit.fill,
                  ),
                ),
                child: GlassmorphicFlexContainer(
                  borderRadius: 15,
                  blur: 18,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.bottomCenter,
                  border: 1,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.2),
                        Color(0xFFFFFFFF).withOpacity(0.2),
                      ],
                      stops: [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.5),
                      Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  child: Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numberOfSquares,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 20),
                        itemBuilder: (BuildContext context, int index) {
                          if (snakePosition.contains(index)) {
                            if (index == 0) {
                              return Center(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          if (index == food) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Container(color: Colors.green)),
                            );
                          } else {
                            return Container(
                                // BG
                                );
                          }
                        }),
                  ),
                ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: StartGame,
                    child: Text(
                      'S T A R T',
                      style: TextStyle(
                        backgroundColor: Colors.grey[600],
                        color: Colors.white,
                         fontSize: 20,
                         ),
                    ),
                  ),
                  Text(
                    'Score:' + snakePosition.length.toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Text(
                    '@ created by A W T Y',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
