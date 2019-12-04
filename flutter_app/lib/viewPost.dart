import 'package:flutter/material.dart';
import 'package:flutter_app/Posts.dart';
import 'dart:convert';
import 'dart:io';
class viewPost extends StatefulWidget{

  postPage createState() =>  postPage();
}

class postPage extends State<viewPost>{
  var image;
  String Email=selectedPost.user.email;

  renderImage(){
    String img=selectedPost.bookimg;
    print(selectedPost.name);
    image=Image.memory(base64Decode(img));
  }


  Widget build(BuildContext context) {
    return Scaffold(



        body: Center(


            child: new ListView(

                children: <Widget> [
                  Text("Condition: "),

                  //Text("Price:  " + selectedPost.price),
                  Text("To get this book contact:  " + "$Email" ),


                  Text("\n"),
                  Text("Image: \n"),
                  Image.memory(base64Decode(selectedPost.bookimg)),

                ]

            )
        )
    );
  }
}
