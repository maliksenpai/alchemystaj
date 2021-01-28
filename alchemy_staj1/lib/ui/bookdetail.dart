import 'package:alchemy_staj1/bloc/cart/cartBloc.dart';
import 'package:alchemy_staj1/bloc/cart/cartEvent.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';

class BookDetailPage extends StatefulWidget{
  Book book;

  @override
  BookDetailPage({this.book});

  @override
  State<StatefulWidget> createState() => _BookDetailPage(book: book);

}

class _BookDetailPage extends State<BookDetailPage>{

  Book book;

  @override
  _BookDetailPage({this.book});


  @override
  Widget build(BuildContext context) {

    CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);


    return Scaffold(
      appBar: AppBar(title: Text(book.name),),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(padding: EdgeInsets.all(16.0)),
                CachedNetworkImage(
                  imageUrl: book.image,
                  progressIndicatorBuilder: (context,url,downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress,),
                  errorWidget: (context,url,error) => Text("Fotoğraf yüklenemedi"),
                ),
                Padding(padding: EdgeInsets.all(16.0)),
                Text("Sayfa Sayısı:"+book.pageCount.toString()+"\n Kitap türü:"+book.typeId.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                book.isAvailable ? Text("Kitap şuan kiralanabilir") : Text("Kitap şuan kiralanamaz"),
                StreamBuilder(
                  stream: _cartBloc.bookstream,
                  builder: (BuildContext context,AsyncSnapshot<List<Book>> snapshot){
                    if(!snapshot.hasData){
                      _cartBloc.add(InitList());
                    }
                    var cartlist = snapshot.data;
                    bool check = false;
                    cartlist.forEach((element) {
                      if(element.bookId==book.bookId){
                        check=true;
                      }
                    });
                    return check ? RaisedButton(onPressed: () {_cartBloc.add(RemoveItem(book: book));},child: Text("Sepetten çıkart"),) : RaisedButton(onPressed: () {_cartBloc.add(AddItem(book: book));},child: Text("Sepete ekle"),);
                  },
                )
              ],
            )

          ],
        ),
      ),
    );
  }

}