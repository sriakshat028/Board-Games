import 'package:flutter/material.dart';

class Sudoku extends StatelessWidget {
  const Sudoku({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Sudoku'),),
      body: const Center(
        child: Text(
          'Coming Soon...',
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
