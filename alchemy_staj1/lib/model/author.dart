class Author{
  int authorId;
  String name;
  String surname;

  Author({this.authorId,this.name,this.surname});

  factory Author.fromJson(Map<String,dynamic> json){
    return Author(
      authorId: json['authorId'],
      name: json['name'],
      surname: json['surname']
    );
  }
}