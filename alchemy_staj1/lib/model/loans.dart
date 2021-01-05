class Loan{
  int borrowId;
  int userId;
  int bookId;
  var takenDate;
  var returnDate;

  Loan({this.borrowId,this.userId,this.bookId,this.takenDate,this.returnDate});

  factory Loan.fromJson(Map<String,dynamic> json){
    return Loan(
      borrowId: json['borrowId'],
      userId: json['userId'],
      bookId: json['bookId'],
      takenDate: json['takenDate'],
      returnDate: json['returnDate']
    );
  }
}