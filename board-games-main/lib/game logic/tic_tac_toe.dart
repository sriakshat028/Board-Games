import 'dart:io';

import 'package:flutter/material.dart';

enum Values { cross, circle, unfilled }
enum PlayerStatus { won, loss, draw, gameRunning }

class TicTacToe extends ChangeNotifier {
  final List<List<Values>> _board = [
    [Values.unfilled, Values.unfilled, Values.unfilled],
    [Values.unfilled, Values.unfilled, Values.unfilled],
    [Values.unfilled, Values.unfilled, Values.unfilled],
  ];
  PlayerStatus status = PlayerStatus.gameRunning;
  List<List<Values>> get board => _board;
  int filled = 0;

  bool turn = false;

  void displayBoard() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (board[i][j] == Values.unfilled) {
          stdout.write(' _ ');
        } else if (board[i][j] == Values.cross) {
          stdout.write(' X ');
        } else if (board[i][j] == Values.circle) {
          stdout.write(' O ');
        }
      }
      debugPrint('\n');
    }
  }

  void computerPlays() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    if (filled >= 9) {
      updateStatus(PlayerStatus.draw);
      return;
    }
    int? threatRow, threatColumn;
    int tr = 0, tc = 0;
    for (int i = 0; i < 3; i++) {
      int countCross = 0, countUnfilled = 0, countCircle = 0;
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == Values.unfilled) {
          tr = i;
          tc = j;
          countUnfilled++;
        } else if (board[i][j] == Values.cross) {
          countCross++;
        } else {
          countCircle++;
        }
      }
      if (countCross == 3) {
        updateStatus(PlayerStatus.won);
        return;
      } else if (countCross == 2 && countUnfilled == 1) {
        //updateBoard(tr, tc, Values.circle);
        threatRow = tr;
        threatColumn = tc;
      } else if (countCircle == 2 && countUnfilled == 1) {
        updateBoard(tr, tc, Values.circle);
        updateStatus(PlayerStatus.loss);
        return;
      } else if (countCircle == 3) {
        updateStatus(PlayerStatus.loss);
        return;
      }
    }
    for (int i = 0; i < 3; i++) {
      int countCross = 0, countUnfilled = 0, countCircle = 0;
      for (int j = 0; j < 3; j++) {
        if (board[j][i] == Values.unfilled) {
          tr = j;
          tc = i;
          countUnfilled++;
        } else if (board[j][i] == Values.cross) {
          countCross++;
        } else {
          countCircle++;
        }
      }
      if (countCross == 3) {
        updateStatus(PlayerStatus.won);
        return;
      } else if (countCross == 2 && countUnfilled == 1) {
        //updateBoard(tr, tc, Values.circle);
        threatRow = tr;
        threatColumn = tc;
      } else if (countCircle == 2 && countUnfilled == 1) {
        updateBoard(tr, tc, Values.circle);
        updateStatus(PlayerStatus.loss);
        return;
      } else if (countCircle == 3) {
        updateStatus(PlayerStatus.loss);
        return;
      }
    }

    //Left Diagonal
    int countCrossl = 0, countUnfilledl = 0, countCirclel = 0;
    for (int i = 0; i < 3; i++) {
      if (board[i][i] == Values.unfilled) {
        tr = i;
        tc = i;
        countUnfilledl++;
      } else if (board[i][i] == Values.cross) {
        countCrossl++;
      } else {
        countCirclel++;
      }
    }
    if (countCrossl == 3) {
      updateStatus(PlayerStatus.won);
      return;
    } else if (countCrossl == 2 && countUnfilledl == 1) {
      //updateBoard(tr, tc, Values.circle);
      threatRow = tr;
      threatColumn = tc;
    } else if (countCirclel == 2 && countUnfilledl == 1) {
      updateBoard(tr, tc, Values.circle);
      updateStatus(PlayerStatus.loss);
      return;
    } else if (countCirclel == 3) {
      updateStatus(PlayerStatus.loss);
      return;
    }

    //Right Diagonal
    int countCross = 0, countUnfilled = 0, countCircle = 0;
    for (int i = 0; i < 3; i++) {
      if (board[i][2 - i] == Values.unfilled) {
        tr = i;
        tc = 2 - i;
        countUnfilled++;
      } else if (board[i][2 - i] == Values.cross) {
        countCross++;
      } else {
        countCircle++;
      }
    }
    if (countCross == 3) {
      updateStatus(PlayerStatus.won);
      return;
    } else if (countCross == 2 && countUnfilled == 1) {
      //updateBoard(tr, tc, Values.circle);
      threatRow = tr;
      threatColumn = tc;
    } else if (countCircle == 2 && countUnfilled == 1) {
      updateBoard(tr, tc, Values.circle);
      updateStatus(PlayerStatus.loss);
      return;
    } else if (countCircle == 3) {
      updateStatus(PlayerStatus.loss);
      return;
    }
    if (board[1][1] == Values.unfilled) {
      updateBoard(1, 1, Values.circle);
    } else if (threatColumn != null) {
      updateBoard(threatRow!, threatColumn, Values.circle);
    } else {
      updateBoard(tr, tc, Values.circle);
    }
    return;
  }

  void updateBoard(int r, int c, Values value) {
    _board[r][c] = value;
    filled++;
    notifyListeners();
  }

  void updateBoardPlayer(int r, int c, Values value) {
    _board[r][c] = value;
    filled++;
    computerPlays();
    notifyListeners();
  }

  void gameReset() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        _board[i][j] = Values.unfilled;
      }
    }
    filled = 0;
    turn = false;
    status = PlayerStatus.gameRunning;
    notifyListeners();
  }

  void updateStatus(PlayerStatus newStatus) {
    status = newStatus;
    notifyListeners();
  }
}
