import 'package:flutter/material.dart';

class Tweet extends StatelessWidget {

  TextEditingController _fieldController = TextEditingController();
  bool _isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tweet"), actions: [
        RaisedButton(
          child: const Text('Tweet'),
          color: Colors.blue,
          textColor: Colors.white,
          shape: const StadiumBorder(),
          onPressed: !_isEnabled==false ? null : () {},
        )
      ]),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                autofocus: true,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "今何してる？",
                ),
                controller: _fieldController,
                onChanged: (text){
                  print(_isEnabled);
                  if(text.length >= 140){
                    _isEnabled = false;
                  }else{
                    _isEnabled = true;
                  }
                }
              )
            )
          ),
          Container(
            child: Row(
              children: [
                // 画像追加
                IconButton(
                  icon: Icon(Icons.photo_library_outlined),
                  tooltip: 'Picture',
                  onPressed: () {},
                ),
                // GIF追加
                IconButton(
                  icon: Icon(Icons.gif_outlined),
                  tooltip: 'Picture',
                  onPressed: () {},
                ),
                // 投票追加
                IconButton(
                  icon: Icon(Icons.add_chart),
                  tooltip: 'Picture',
                  onPressed: () {},
                ),
                // 位置情報追加
                IconButton(
                  icon: Icon(Icons.add_location_alt_outlined),
                  tooltip: 'Picture',
                  onPressed: () {},
                ),

                // 文字数
                
              ]
            ),
            height: 40,
          ),
        ]
      ),
    );
  }
}
