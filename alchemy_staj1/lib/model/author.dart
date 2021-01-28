class Author{
  int authorId;
  String name;
  String surname;
  String photo;

  Author({this.authorId,this.name,this.surname,this.photo});

  factory Author.fromJson(Map<String,dynamic> json){
    return Author(
      authorId: json['authorId'],
      name: json['name'],
      surname: json['surname'],
      photo: json['photo']
    );
  }
}