import 'package:flutter_app/Posts.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'viewPost.dart';




class myList extends StatefulWidget{
  List<Post> Posts= mypost;
  MyList createState()=>MyList();
}

class MyList extends State<myList>{
  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My List'),
      ),
      body: new RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
            mypost.removeAt(0);
          });
        },
        child: new ListView(
          children: mypost.map(_buildItem).toList(),
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