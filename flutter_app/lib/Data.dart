import 'package:flutter/material.dart';
import 'dart:core';



class Book{

  var price;
  var name;
  var author;
  var username;
  var image;

  Book(this.price,this.name,this.author,this.username,this.image);

  Book.unlaunced(var price,var name,var author,var username,var image):this(price,name,author,username,image);


}

List<Book> Mybooks;
//List<Book> SearchResult;


