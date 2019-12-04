import 'package:flutter/material.dart';
import 'package:flutter_app/Data.dart';
import 'package:flutter_app/search.dart' as s;
import 'package:flutter_app/Posts.dart';
import 'package:flutter_app/viewPost.dart';


class SearchResult{

  var count;

  List books;


  SearchResult.fromJson(Map<String,dynamic> json)
   :count=json['count'],
    books=json['books'];


}


SearchResult sr;


class ViewResult extends StatefulWidget{
  List<Post> Posts= post;
_ViewResult createState(){
  return  _ViewResult();}
}

class _ViewResult extends State<ViewResult> {

  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Search Results'),
      ),
      body: new RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
            post.removeAt(0);
          });
        },
        child: new ListView(
          children: post.map(_buildItem).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(Post post) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new ExpansionTile(
        title: new Text(post.name, style: new TextStyle(fontSize: 24.0)),
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("${post} user"),
              new IconButton(
                icon: new Icon(Icons.launch),
                onPressed: () async {
                    selectedPost=post;
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>viewPost()),);

                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

