class User{
  int id;
  String name;
  String surname;
  var birthdate;
  String gender;

  User({this.id,this.name,this.surname,this.birthdate,this.gender});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id : json['id'],
      name : json['name'],
      surname: json['surname'],
      birthdate: json['birthdate'],
      gender: json['gender']
    );
  }

  

}