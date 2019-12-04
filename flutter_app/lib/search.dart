import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Data.dart';

import 'package:flutter_app/SearchResult.dart';
import 'package:flutter_app/Posts.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_app/Posts.dart';
import 'package:flutter_app/URL.dart';
import 'auth.dart';
import 'viewPost.dart';


bool _loading =false;






class Search extends StatefulWidget{
  @override
  SearchForm createState() {
    return SearchForm();
  }

}

class SearchForm extends State<Search>{
  @override
  var _bookController=new TextEditingController();
  var _authornameController=new TextEditingController();
  List<String> University = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedUni;

   Future fetchData()async{

    String name=_bookController.text;
    String author=_authornameController.text;
    String token=aut.token;
    List<Post> _result=List<Post>();


    http.Response response=await http.get('''$url/books/''',headers: {'content-type':'application/json','auth-token':'$token'}


    );
    var json=jsonDecode(response.body);
    SearchResult s=SearchResult.fromJson(json);
    sr=s;



    for(int i=2;i<s.count-5;i++){
       Post p= new Post.fromJson(s.books[i]);
       print(s.books[i]['user']);
        if(p.name==name||p.author==author)
       _result.add(p);
    }


    post=_result;


  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Search'),

      ),









      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[




            TextField(
              decoration: InputDecoration(
                  hintText: 'Book'
              ),
               controller: _bookController,
            ),


            TextField(
              decoration: InputDecoration(
                  hintText: 'Author'
              ),
              controller: _authornameController,

            ),





      DropdownButton(
        hint: Text('University'), // Not necessary for Option 1
        value: _selectedUni,
        onChanged: (newValue) {
          setState(() {
            _selectedUni = newValue;
          });
        },
        items: University.map((location) {
          return DropdownMenuItem(
            child: new Text(location),
            value: location,
          );
        }).toList()),



           Spacer(),

    _loading ? CircularProgressIndicator()  : SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () async {
                     await fetchData();

                     Navigator.push(
                     context,
    MaterialPageRoute(builder: (context) =>ViewResult()),);




  },
              ),
            )
          ],
        ),
      ),














    );
  }

}
