import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/Register.dart';
import 'package:flutter_app/URL.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/User.dart';
import 'package:flutter_app/auth.dart';
import 'package:flutter_app/SearchResult.dart';
import 'package:flutter_app/Posts.dart';
class LoginPage extends StatefulWidget{


  Login createState() => Login();



}

class Login extends State<LoginPage>{
  Auth auth;
  var _emailController= new TextEditingController();
  var _passwordController= new TextEditingController();


  Future fetchData()async{


    String token=aut.token;
    List<Post> _result=List<Post>();


    http.Response response=await http.get('''$url/books/''',headers: {'content-type':'application/json','auth-token':'$token'}


    );
    var json=jsonDecode(response.body);
    SearchResult s=SearchResult.fromJson(json);
    sr=s;



    for(int i=2;i<s.count-5;i++){

      Post p=new Post.fromJson(sr.books[i]);
      if(p.user.email==_emailController.text)
        _result.add(p);

    }

    mypost=_result;





  }


  Widget build(BuildContext context) {

    final signUp = Material(
        borderRadius:BorderRadius.horizontal(),
        color: Color(0xff01A0C7),

        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),);
            },
            child: Text("SignUp",
              textAlign: TextAlign.center,
            )

        ));

   Future<bool> Login()async{

     String email=_emailController.text;
     String password=_passwordController.text;
     String jsonstr="""{"email":"$email","password":"$password"}""";
     print(jsonstr);
     http.Response response =await http.post('$url/user/login',headers:
     {
       'content-type':'application/json'
     },
      body:jsonstr

     );


      if(response.statusCode!=200)
      return false;
      Map<String,dynamic> j=jsonDecode(response.body);
      Auth a=new Auth.fromJson(j);

      aut=a;




      return true;



    }



    final emailField = TextField(
      obscureText: false,

      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:

          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          controller: _emailController,
    );

    final passwordField = TextField(
      obscureText: true,

      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
         controller: _passwordController,
    );
    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: ()async {

              User temp=new User('',_emailController.text,_passwordController.text,'');
              u=temp;
          var a=await Login();
           if(a==false)
           {print('incorrect credentials');}

           else{
            await fetchData();
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),);

           }


            },
            child: Text("Login",
              textAlign: TextAlign.center,
            )
        ));


    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height:10.0,

                ),
                signUp,
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}