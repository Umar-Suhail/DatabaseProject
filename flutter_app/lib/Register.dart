import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter_app/URL.dart';
import 'package:flutter_app/User.dart';
import 'package:http/http.dart' as http;
String dropdownValue="City";

User user;
class Register extends StatefulWidget {
  @override
  RegisterPage createState() =>  RegisterPage();
}

class RegisterPage extends State<Register> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController   _emailController  = new TextEditingController();
  TextEditingController _addressController  = new TextEditingController();
  TextEditingController _mobno              = new TextEditingController();


  Future<String> Register(User user)async{
   // Map<String,dynamic> obj=user.toJson();
    print('usercreate');
    String username=user.username;
    String email=user.email;
    String password=user.password;
    String mobNo=user.mobNo;
    String address=_addressController.text;
    String jsonStr= """{"username":"$username","email":"$email","password":"$password","mobNo":"$mobNo","address":"$address"}""";
    print(jsonStr);
    http.Response response=await http.post('$url/user/register',headers:
    {'content-type':'application/json'},
    body: jsonStr);
    print(response.statusCode);
    print(response.body);

    return response.body;

  }




  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[



            TextField(
              decoration: InputDecoration(
                  hintText: 'Username'
              ),
              controller: _usernameController,
            ),

            TextField(
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
                controller: _emailController
            ),

            TextField(
                decoration: InputDecoration(
                    hintText: 'Password'

                ),
                controller:_passwordController
            ),


            TextField(
                decoration: InputDecoration(
                    hintText: 'Mobile No'
                ),
                controller: _mobno
            ),




            TextField(
                decoration: InputDecoration(
                    hintText: 'Address'
                ),
                controller: _addressController
            ),



            /*DropdownButton<String>(
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
              items: <String>['City','Karachi', 'Islamabad', 'Lahore', 'Peshawar']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),*/



            _isLoading ? CircularProgressIndicator()  : SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () async {

                  String u=_usernameController.text;
                  String p=_passwordController.text;
                  String e=_emailController.text;
                  String m=_mobno.text;
                  User user=new User(u,e,p,m);


                  Register(user);




                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

