import 'dart:developer';

import 'package:alchemy_staj1/bloc/cart/cartBloc.dart';
import 'package:alchemy_staj1/bloc/cart/cartState.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _CartPage();

}

class _CartPage extends State<CartPage>{
  CartBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Kitaplar"),),
      body: SafeArea(
        child: BlocConsumer<CartBloc,CartState>(
          cubit: bloc,
          listener: (context,state){
            state = bloc.state;
            if(state is InitState){
              return ListBooks();
            }else{
              return Container();
            }
          },
          builder: (context,state){
            state = bloc.state;
            if(state is InitState){
              return ListBooks();
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget ListBooks(){
    return StreamBuilder(
      stream: bloc.bookstream,
      builder: (BuildContext context,AsyncSnapshot<List<Book>> snapshot){
        log(snapshot.data.length.toString());
        if(snapshot.hasData){
          var list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(list[index].name),
              );
            },
          );
        }else{
          return Center(child: Text("Sepetiniz boş"),);
        }
      },
    );
  }

}