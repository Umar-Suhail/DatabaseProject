
import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/search.dart';
import 'package:flutter_app/Data.dart' as D;

import 'dart:io';
import 'package:flutter_app/URL.dart';
import 'package:flutter_app/User.dart';
import 'package:flutter_app/ImageInput.dart';
import 'package:image_picker/image_picker.dart';
import 'auth.dart';

bool _p=false;


class PostForm extends StatefulWidget{
  @override
  Post createState() {
    return Post();

  }

}


class Post extends State<PostForm>{
  @override
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  var _nameController =new TextEditingController();
  var _authorController=new TextEditingController();
  var _priceController=new TextEditingController();
  var _descriptionController=new TextEditingController();

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }



  Future makePost()async{

    String name=_nameController.text;
    String author=_authorController.text;
    String price =_priceController.text;
    String user=aut.id;
    print(user);
    String bookImage=base64Image;
    var token=aut.token;

    var jsonstr="""{"name":"$name","author":"$author","price":"$price","userID":"$user","bookImage":"$bookImage"}""";

    http.Response response =await http.post('$url/books/',headers: {'content-type':'application/x-www-form-urlencoded',
      'content-type':'application/json',
     'auth-token':'$token'

    }

    ,body:jsonstr);
    print(response.body);



  }
  var dropdownValue;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post'),),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            TextField(
              decoration: InputDecoration(
                  hintText: 'Name of Book'
              ),
              controller: _nameController,
            ),


            TextField(
              decoration: InputDecoration(
                  hintText: 'Author Name'
              ),
              controller: _authorController,
            ),

            TextField(
                decoration: InputDecoration(
                    hintText: 'Price'
                ),
                controller: _priceController
            ),



            TextField(
                decoration: InputDecoration(
                    hintText: 'Description'

                ),
                controller:_descriptionController
            ),



            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Exchange','Sell', 'Rent']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),





            _p ? CircularProgressIndicator  : SizedBox(
              height: 30,
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () {

                  chooseImage();


                },
              ),
            ),







            _p ? CircularProgressIndicator  : SizedBox(
              height: 20,
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () {

                      makePost();


                },
              ),
            )








          ],
        ),
      ),
    );
  }

}