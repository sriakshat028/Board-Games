import 'package:flutter/material.dart';

class BoardGame3 extends StatelessWidget {
  const BoardGame3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Random'),),
      body: const Center(
        child: Text(
          'Working On it',
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
