import 'dart:convert';
import 'package:flutter_app/User.dart';
class Post{

  String name;
  String author;
  String bookimg;
  User  user;
  var price;

  Post(this.name,this.author,this.bookimg,this.user,this.price);

  Post.fromJson(Map<String,dynamic> json)
   :name=json['name'],
   author=json['author'],
   bookimg=json['bookImage'],
   user=User.fromJson(json['user']),
   price=json['price'];

}

List<Post> post=List<Post>();

Post selectedPost;

List<Post> mypost=List<Post>();