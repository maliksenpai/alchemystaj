import 'dart:developer';

import 'package:alchemy_staj1/bloc/cart/cartBloc.dart';
import 'package:alchemy_staj1/bloc/cart/cartEvent.dart';
import 'package:alchemy_staj1/bloc/cart/cartState.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:alchemy_staj1/ui/menu.dart';
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
          listener: (context,state) async {
            state = bloc.state;
            if(state is InitState){
              return ListBooks();
            }else if(state is CompletedState){
              await Future.delayed(const Duration(seconds: 2)).then((value) => finishedLoan());
              return Center(child: Text("İslem basarili,menüye yönlediriliyorsunuz"),);
            }else if(state is ErrorState){
              await Future.delayed(const Duration(seconds: 2)).then((value) => finishedLoan());
              return Center(child: Text(state.error+",menüye yönlediriliyorsunuz"),);
            }else{
              return Container();
            }
          },
          builder: (context,state){
            state = bloc.state;
            if(state is InitState){
              return ListBooks();
            }else if(state is CompletedState){
              return Center(child: Text("İşlem başarılı, menüye yönlediriliyorsunuz"),);
            }else if(state is ErrorState){
              return Center(child: Text(state.error+",menüye yönlediriliyorsunuz"),);
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
        if(snapshot.hasData){
          var list = snapshot.data;
          return Column(
            children: [
              Expanded(child:
                ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(list[index].name),
                    );
                  },
                ),
              ),
              RaisedButton(onPressed: () =>checkLoan(list),child: Text("Kirala"),)
            ],
          );
        }else{
          return Center(child: Text("Sepetiniz boş"),);
        }
      },
    );
  }
  
  checkLoan(List<Book> list){
    bool check = true;
    list.forEach((element) { 
      if(!element.isAvailable){
        check=false; //listede kiralanamayacak kitap var mı diye konntrol ediyoruz
      }
    });
    check ? bloc.add(CompleteLoan()) : bloc.add(ErrorLoan());
  }

  finishedLoan() {
    bloc.add(ClearLoan());
    //Navigator.of(context).pop();
    Navigator.of(context).pop(true);
  }
}