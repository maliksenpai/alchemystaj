class Book{
  int bookId;
  String name;
  int pageCount;
  int typeId;
  int authorId;
  bool isAvailable;

  Book({this.bookId,this.name,this.pageCount,this.typeId,this.authorId,this.isAvailable});

  factory Book.fromJson(Map<String,dynamic> json){
    return Book(
        bookId: json['bookId'],
        name: json['name'],
        pageCount: json['pageCount'],
        typeId: json['typeId'],
        authorId: json['authorId'],
        isAvailable: json['isAvailable']
    );
  }
}