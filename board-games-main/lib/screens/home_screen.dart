import 'dart:math';

import 'package:boardgames/screens/board_game1.dart';
import 'package:boardgames/screens/board_game2.dart';
import 'package:flutter/material.dart';
import 'package:boardgames/navigation.dart';

import 'board_game3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _boardGames = ['TicTacToe', 'Sudoku', 'Random'];

  final List<Widget> _widget = [
    const BoardGame1(),
    const Sudoku(),
    const BoardGame3()
  ];

  final int boardGame1Score = 100;

  final List<Color> _colors = [Colors.indigo, Colors.blue, Colors.deepPurple];

  Color _colorMode = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorMode,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _boardGames.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    right: 20,
                    left: 20,
                  ),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                      leading: const Icon(
                        Icons.coffee,
                        size: 40,
                      ),
                      trailing: IconButton(
                        onPressed: changeColorMode,
                        icon: const Icon(Icons.dark_mode),
                      ),
                      title: const Text(
                        'Hii There,',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonHomeScreen(
                  tileColor: _colors[index % _colors.length],
                  boardGame1: _boardGames[index % _boardGames.length],
                  boardGame1Score: boardGame1Score,
                  widget: _widget[index % _widget.length],
                ),
              ],
            );
          } else {
            return ButtonHomeScreen(
              tileColor: _colors[index % _colors.length],
              boardGame1: _boardGames[index % _boardGames.length],
              boardGame1Score: boardGame1Score,
              widget: _widget[index % _widget.length],
            );
          }
        },
      ),
    );
  }

  void changeColorMode() {
    setState(() {
      if (_colorMode == Colors.white) {
        _colorMode = Colors.black;
      } else {
        _colorMode = Colors.white;
      }
    });
  }
}

class ButtonHomeScreen extends StatelessWidget {
  const ButtonHomeScreen({
    Key? key,
    required this.boardGame1,
    required this.boardGame1Score,
    required this.widget,
    required this.tileColor,
  }) : super(key: key);

  final String boardGame1;
  final int boardGame1Score;
  final Widget widget;
  final Color tileColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        right: 50,
        left: 50,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tileColor,
      ),
      child: ListTile(
        title: Text(
          boardGame1,
          style: const TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          Icons.gamepad,
          color: Colors.white,
        ),
        trailing: Text(
          boardGame1Score.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () => changeScreen(context, widget),
      ),
    );
  }
}
