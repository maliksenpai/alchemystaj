import 'package:alchemy_staj1/model/author.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:alchemy_staj1/model/loans.dart';

class MenuItems{

  MenuItems(){}

  List<Book> books = [
    Book(
        bookId: 1,
        image: "https://i.picsum.photos/id/723/200/300.jpg?hmac=EtJwe3DxhZ1GDiNghxWaO92pvcPcjg02wJzc7Qj7Lr0",
        name: "Deneme1",
        pageCount: 100,
        typeId: 1,
        authorId: 1,
        isAvailable: true),
    Book(
        bookId: 2,
        image: "https://i.picsum.photos/id/766/200/300.jpg?hmac=yPmyGIdCe3ag8jlW87DzVijW_xLn1vzaiwrJvIChFcM",
        name: "Deneme2",
        pageCount: 120,
        typeId: 1,
        authorId: 2,
        isAvailable: false),
    Book(
        bookId: 3,
        image: "https://i.picsum.photos/id/142/200/300.jpg?hmac=B08HyXonHhJPFpULUNgMfoCFGZqymUB3NhBxo3iWTnc",
        name: "Deneme3",
        pageCount: 130,
        typeId: 1,
        authorId: 1,
        isAvailable: true),
    Book(
        bookId: 4,
        image: "https://i.picsum.photos/id/1084/200/300.jpg?hmac=JQMQbKvpN6_d6r-fiuOEYe1Dz6f2gfGIkTvsx0nLJUQ",
        name: "Deneme4",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 5,
        image: "https://i.picsum.photos/id/579/200/300.jpg?hmac=9MD8EV4Jl9EqKLkTj5kyNdBUKQWyHk2m4pE4UCBGc8Q",
        name: "Deneme5",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 6,
        image: "https://i.picsum.photos/id/370/200/300.jpg?hmac=7gPWuhI1_LDcGkEssyW-1sPKu9NVl1KUoOs0nH7KXno",
        name: "Deneme6",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 7,
        image: "https://i.picsum.photos/id/385/200/300.jpg?hmac=IG8cHDliDmlgbSYX1yquX_5cAHcuS_O378oPs5rZGrU",
        name: "Deneme7",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 8,
        image: "https://i.picsum.photos/id/881/200/300.jpg?hmac=OaIsS2cuxcnUpCVdxcFoc8JwfJgzWEv2Z9F_qEN9tHU",
        name: "Deneme8",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 9,
        image: "https://i.picsum.photos/id/273/200/300.jpg?hmac=C0IK2DPqr03oiShSklDGIHBzHorcmVrky7A_uvBEzIM",
        name: "Deneme9",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 10,
        image: "https://i.picsum.photos/id/19/200/300.jpg?hmac=znGSIxHtiP0JiLTKW6bT7HlcfagMutcHfeZyNkglQFM",
        name: "Deneme10",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 11,
        image: "https://i.picsum.photos/id/531/200/300.jpg?hmac=zfPpbPSZ6_bXrCHp-HkvsObzLfkIb7pvmBoZhXrjKo4",
        name: "Deneme11",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 12,
        image: "https://i.picsum.photos/id/1063/200/300.jpg?hmac=Y5MNeIkUM7RWMTL3uI7dMe1ySooJ0cdsERALSOWRAeY",
        name: "Deneme12",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 13,
        image: "https://i.picsum.photos/id/642/200/300.jpg?hmac=P8pCy5u7t4JlHkwIUFsWxnCfi2bWmYGey75V_299YPg",
        name: "Deneme13",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 14,
        image: "https://i.picsum.photos/id/194/200/300.jpg?hmac=jZgjsqqVvdWnXHdytjS2JPImgQFz9bGSyVQ31-b_eH4",
        name: "Deneme14",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 15,
        image: "https://i.picsum.photos/id/35/200/300.jpg?hmac=No1hMogzX_PUqgWDfLRCc4wGPYTIeviBhJbzjqskoMA",
        name: "Deneme15",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 16,
        image: "https://i.picsum.photos/id/981/200/300.jpg?hmac=H3LDLzNJiLGQYdx_Q7g_Us-x8VxR-aK5TglLyGlQHDk",
        name: "Deneme16",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 17,
        image: "https://i.picsum.photos/id/209/200/300.jpg?hmac=O_heTT23fut3YnBKcsYxjoH_MCl9YGPcxXx-ZHOjBgc",
        name: "Deneme17",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 18,
        image: "https://i.picsum.photos/id/206/200/300.jpg?hmac=zgY9ucK8PnViYfAc_jWui8B3N-I1-cVdM4BtXYOpk7I",
        name: "Deneme18",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 19,
        image: "https://i.picsum.photos/id/629/200/300.jpg?hmac=YTSnJIQbXgJTOWUeXAqVeQYHZDodXXFFJxd5RTKs7yU",
        name: "Deneme19",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 20,
        image: "https://i.picsum.photos/id/802/200/300.jpg?hmac=q6ItUSh1lSpO66uCg28JvcSG6TC_XXIOgCwifpzTD9M",
        name: "Deneme20",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),
    Book(
        bookId: 21,
        image: "https://i.picsum.photos/id/789/200/300.jpg?hmac=nu1PpKsVA8Td2PEYonJWrmrriU-Km5XoKoEZQ-Tq-6E",
        name: "Deneme21",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false),

  ];
  List<Author> authors = [
    Author(authorId: 1, name: "Deneme1", surname: "1Deneme",photo: "https://i.picsum.photos/id/962/200/300.jpg?hmac=wvuv8EVOoNE5J3sBkBx-1wcVHNbgJ_Z1dS98YhnShjM"),
    Author(authorId: 2, name: "Deneme2", surname: "2Deneme",photo: "https://i.picsum.photos/id/209/200/300.jpg?hmac=O_heTT23fut3YnBKcsYxjoH_MCl9YGPcxXx-ZHOjBgc"),
    Author(authorId: 3, name: "Deneme3", surname: "3Deneme",photo: "https://i.picsum.photos/id/428/200/300.jpg?hmac=yZnpqAvuXjLW6NjhE0OFa2GwK6XcNLPBIrI3yr4yFsk")
  ];

  List<Loan> loans = [
    Loan(
        borrowId: 11,
        userId: 1,
        bookId: 111,
        takenDate: 1709953808,
        returnDate: 2000709853408),
    Loan(
        borrowId: 2,
        userId: 0,
        bookId: 1,
        takenDate: 3258354,
        returnDate: 2000709853408)
  ];


}