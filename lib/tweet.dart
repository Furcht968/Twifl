import 'package:flutter/material.dart';

class Tweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tweet"),
        actions: [
          RaisedButton(
            child: const Text('Tweet'),
            color: Colors.blue,
            textColor: Colors.white,
            shape: const StadiumBorder(),
            onPressed: () {},
          )
        ]
      ),
      body: Center(
        child: TextField(),
      ),
    );
  }
}