class Auth{

  var token;
  var id;


  Auth(this.token,this.id);

  Auth.unlaunched(String token,String id):this(token,id);

  Auth.fromJson(Map<String, dynamic> json)
   :token=json['token'],
    id=json['_id'];

}


Auth aut;