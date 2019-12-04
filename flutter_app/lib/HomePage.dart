import 'package:flutter/material.dart';
import 'Package:flutter_app/PostForm.dart';
import 'Package:flutter_app/Search.dart';
import 'package:flutter_app/myList.dart';


class HomePage extends StatefulWidget{
  @override
  Home createState() {
    return Home();
  }

}

class Home extends State<HomePage> {
  @override
  bool _a =false;
  var a=Column();
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:Text('Home Page'),
       centerTitle: true,

      ),
      body:Padding(
          padding: const EdgeInsets.all(32.0),
      child: Column(


          mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[

     _a ? CircularProgressIndicator :SizedBox(
    height: 40,
    width: double.infinity,
    child: RaisedButton(
    color: Colors.blue,
    child: Text(
    'List A book',
    style: TextStyle(color: Colors.white),
    ),
     onPressed: (){
      Navigator.push(context,
          MaterialPageRoute(builder:(context)=>PostForm()));
     },
    )
      ),

        Spacer(),

        _a ? CircularProgressIndicator :SizedBox(
            height: 40,
            width: double.infinity,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Manage Profile',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
               /* Navigator.push(context,
                    MaterialPageRoute(builder:(context)=>UserProfile()));*/
              },
            )
        ),






        Spacer(),

        _a ? CircularProgressIndicator :SizedBox(
            height: 40,
            width: double.infinity,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'My List',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){

                Navigator.push(context,
                    MaterialPageRoute(builder:(context)=>myList()));
              },
            )
        ),

        Spacer(),

        _a ? CircularProgressIndicator :SizedBox(
            height: 20,
            width: double.infinity,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder:(context)=>Search()));
              },
            )
        ),


        ],

      ),

      ),




    );

  }


}





