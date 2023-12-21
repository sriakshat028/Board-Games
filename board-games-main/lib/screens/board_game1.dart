import 'package:boardgames/game%20logic/tic_tac_toe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardGame1 extends StatefulWidget {
  const BoardGame1({Key? key}) : super(key: key);

  @override
  _BoardGame1State createState() => _BoardGame1State();
}

class _BoardGame1State extends State<BoardGame1> {
  @override
  Widget build(BuildContext context) {
    final _game = Provider.of<TicTacToe>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe! 3 in a Row!'),
      ),
      body: _game.status == PlayerStatus.gameRunning
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _game.filled % 2 != 0
                    ? Container(
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
                        child: const Card(
                          elevation: 6,
                          child: ListTile(
                            leading: Icon(
                              Icons.computer,
                              size: 40,
                            ),
                            title: Text(
                              'Computer Is Thinking...',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 200,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[0][0]),
                          onPressed: () {
                            _game.updateBoardPlayer(0, 0, Values.cross);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[0][1]),
                          onPressed: () {
                            _game.updateBoardPlayer(0, 1, Values.cross);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[0][2]),
                          onPressed: () {
                            _game.updateBoardPlayer(0, 2, Values.cross);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[1][0]),
                          onPressed: () {
                            _game.updateBoardPlayer(1, 0, Values.cross);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[1][1]),
                          onPressed: () {
                            _game.updateBoardPlayer(1, 1, Values.cross);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[1][2]),
                          onPressed: () {
                            _game.updateBoardPlayer(1, 2, Values.cross);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[2][0]),
                          onPressed: () {
                            _game.updateBoardPlayer(2, 0, Values.cross);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[2][1]),
                          onPressed: () {
                            _game.updateBoardPlayer(2, 1, Values.cross);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: IconButton(
                          icon: giveIcon(_game.board[2][2]),
                          onPressed: () {
                            _game.updateBoardPlayer(2, 2, Values.cross);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _game.gameReset();
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ),
                _game.filled % 2 == 0
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          right: 50,
                          left: 50,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple,
                        ),
                        child: const ListTile(
                          title: Text(
                            'Your Turn',
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: Icon(
                            Icons.gamepad,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            )
          : Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _game.gameReset();
                  });
                },
                child: Text(
                  endGameText(_game.status) + ' Restart?',
                ),
              ),
            ),
    );
  }

  String endGameText(PlayerStatus status) {
    if (status == PlayerStatus.draw) return 'Game Draw';
    if (status == PlayerStatus.won) return 'You won';
    if (status == PlayerStatus.loss) {
      return 'You loose';
    } else {
      return 'None';
    }
  }

  Icon giveIcon(Values value) {
    if (value == Values.unfilled) {
      return const Icon(
        Icons.book,
        color: Colors.white,
      );
    } else if (value == Values.cross) {
      return const Icon(Icons.clear_outlined);
    } else {
      return const Icon(Icons.circle_outlined);
    }
  }
}

class TicTacToeBox extends StatelessWidget {
  const TicTacToeBox({
    Key? key,
    required this.content,
  }) : super(key: key);
  final bool content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Card(
        child: IconButton(
          icon: Icon(
            content ? Icons.clear_outlined : Icons.circle_outlined,
            size: 40,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
