import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app/URL.dart';
class User{
  String username;
  String email;
  String password;
  String mobNo;
  User.fromJson(Map<String, dynamic> json)
     :username = json['username'],
    email = json['email'],
    password=json['password'],
    mobNo=json['mobNo'];


  User(this.username,this.email,this.password,this.mobNo);

  User.unlaunched(String username,String email,String password,String mobno):this(username,email,password,mobno);

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'email': email,
        'password':password

      };


}

User u;