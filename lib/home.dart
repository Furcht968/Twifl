import 'package:flutter/material.dart';
import 'package:twifl/tweet.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main"),
      ),
      body: Center(
        child: Text("Main"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Tweet()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}