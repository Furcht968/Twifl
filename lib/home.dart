import 'package:flutter/material.dart';
import 'package:twifl/tweet.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:twifl/apiData.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<Widget> _timelineData = [
    Container(
      padding: EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)
          )
        ]
      )
    )
  ];
  @override
  void initState() {

    super.initState();
    _load();
  }
  List<Widget> JSONtoTwitter(List lsdata){
    List<Widget> cvData = [];
    num mojisu = 27;
    num umojisu = 0;
    User? user;
    String name;
    String? tweet;
    for(int i=0; i<lsdata.length; i++){
      bool result = new RegExp(r"^RT @.*:").hasMatch(lsdata[i]["text"]);
      String? id = new RegExp(r"^RT @(.*):").stringMatch(lsdata[i]["text"]);
      if(result){
        user = lsdata[i]["tweet"].retweetedStatus.user;
        tweet = lsdata[i]["tweet"].retweetedStatus.fullText;
      }else{
        user = lsdata[i]["tweet"].user;
        tweet = lsdata[i]["tweet"].fullText;
      }
      name = user?.name ?? "Null";
      if(name.length >= mojisu){
        name = name.substring(0,mojisu.toInt())+"...";
      }
      String icon = user?.profileImageUrlHttps ?? "Null";
      String scrName = user?.screenName ?? "Null";
      if(lsdata[i]["text"]!=null){
        cvData.add(
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))
            ),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(3),
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(icon),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        name,
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),/*
                    Text(
                      "@"+scrName,
                      style: TextStyle(
                        color: Color(0xff777777),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),*/
                    Container(
                       child: Text(HtmlCharacterEntities.decode(tweet ?? "Null"))
                    )
                  ]
                ),
              ]
            )
          )
        );
      }
    }
    return cvData;
  }
  Future<void> _load() async {
    apiData data = apiData();
    List tweets = [];
    List<Widget> tweets_wd;
    final twitterApi = TwitterApi(
      client: TwitterClient(
        consumerKey: data.KEY,
        consumerSecret: data.SECRET,
        token: data.ACT,
        secret: data.ATS,
      ),
    );

    final homeTimeline = await twitterApi.timelineService.homeTimeline(
      count: 200,
    );
    
    homeTimeline.forEach((tweet) => tweets.add({"tweet":tweet, "text":tweet.fullText, "user":tweet.user}));
    tweets_wd = JSONtoTwitter(tweets);
    setState(() {
      _timelineData = tweets_wd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main"),
      ),
      body: ListView(
        children: _timelineData
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TweetScr()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}