import 'package:flutter/material.dart';
import 'package:toappprojct/ui/todo_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo APP"),
        backgroundColor: Colors.purple,
      ),
      body: TodoScreen(),
    );
  }
}
