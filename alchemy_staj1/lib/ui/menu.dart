import 'dart:developer';

import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/bloc/menu/menuBloc.dart';
import 'package:alchemy_staj1/bloc/menu/menuEvent.dart';
import 'package:alchemy_staj1/bloc/menu/menuState.dart';
import 'package:alchemy_staj1/model/author.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:alchemy_staj1/model/loans.dart';
import 'package:alchemy_staj1/ui/bookdetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MenuPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MenuPage();
  }
}


class _MenuPage extends State<MenuPage>{
  int index;
  MenuBloc bloc = MenuBloc();
  @override
  Widget build(BuildContext context) {
    if(index==null){
      index=0;
      log("boş");
      setState(() {
        bloc.add(ChangeMenuEvent(page: 0));
      });
    }
    return Scaffold(
        appBar: AppBar(title: Text("Menu"),),
        body: SafeArea(
          child: BlocConsumer<MenuBloc,MenuState>(
            listener: (context,state){
              bloc = BlocProvider.of<MenuBloc>(context);
              state = bloc.state;
              log("list:"+state.toString());
              if(state is BooksState){
                return Books();
              }else if(state is AuthorsState){
                return Authors();
              }else if(state is LoansState){
                return Loans();
              }else{
                return Container();
              }
            },
            builder: (contextt,state){
              bloc = BlocProvider.of<MenuBloc>(context);
              state = bloc.state;
              log("build:"+state.toString());
              if(state is BooksState){
                return Books();
              }else if(state is AuthorsState){
                return Authors();
              }else if(state is LoansState){
                return Loans();
              }else{
                return Container();
              }
            },
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.blue),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: changePage,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("Kitaplar")),
              BottomNavigationBarItem(icon: Icon(Icons.account_box_sharp),title: Text("Yazarlar")),
              BottomNavigationBarItem(icon: Icon(Icons.local_library),title: Text("Ödünç alınanlar"))
            ],
          ),
        )
    );




  }




  void changePage(int i){
    setState(() {
      index=i;
      bloc.add(ChangeMenuEvent(page: i));
    });
  }


  Widget Books(){
    ScrollController controller;
    controller = new ScrollController();

    _scrollListener(){
      if(controller.position.pixels==controller.position.maxScrollExtent){
        setState(() {
           bloc.add(MoreBooks());
        });

      }
    }
    controller.addListener(_scrollListener);


    return StreamBuilder(
        stream: bloc.bookstream,
        builder: (BuildContext context,AsyncSnapshot<List<Book>> snapshot){
          log("veri kontrol");
          if(snapshot.hasData){

            var list = snapshot.data;
            return ListView.builder(
              itemCount: list.length,
              controller: controller,
              itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetail()));},
                    leading:CachedNetworkImage(
                      imageUrl: list[index].image,
                      progressIndicatorBuilder: (context,url,downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress,),
                      errorWidget: (context,url,error) => Text("Fotoğraf yüklenemedi"),
                    ),
                    title: Text(list[index].name),
                    trailing: list[index].isAvailable ? Text("Kiralanabilir",style: TextStyle(color: Colors.green),) : Text("Şuan kiralanamaz",style: TextStyle(color: Colors.red),),
                    subtitle: Text("Sayfa sayısı:"+list[index].pageCount.toString()),
                  );
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        },
    );

  }

  Widget Authors(){

    return StreamBuilder(
      stream: bloc.authorstream,
      builder: (BuildContext context,AsyncSnapshot<List<Author>> snapshot){
        if(snapshot.hasData){
          var list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                title: Text(list[index].name),
                subtitle: Text(list[index].surname),
              );
            },
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget Loans(){

    return StreamBuilder(
      stream: bloc.loanstream,
      builder: (BuildContext context,AsyncSnapshot<List<Loan>> snapshot){
        if(snapshot.hasData){
          var list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                title: Text(list[index].bookId.toString()),
                subtitle: Text("Süre bitiş tarihi:"+DateTime.fromMicrosecondsSinceEpoch(list[index].returnDate*1000).toLocal().toString()),
              );
            },
          );
        }else{
          return Container(
            child: Center(child: Text("Ödünç alınan kitabınız yok"),),
          );
        }
      },
    );
  }

}


/*Widget pages(int i){
    if(index==0){
      return Books();
    }else if(index==1){
      return Authors();
    }else{
      return Loans();
    }
  }*/

/*return Scaffold(
        appBar: AppBar(title: Text("Menu"),),
        body: SafeArea(
          child: BlocConsumer<MenuBloc,MenuState>(
            listener: (contextt,state){
              bloc = BlocProvider.of<MenuBloc>(context);
              state=bloc.state;
              log("list:"+state.toString());
              if(state is BooksState){
                return Books();
              }else if(state is AuthorsState){
                return Authors();
              }else if(state is LoansState){
                return Loans();
              }else{
                return Container();
              }
            },
            builder: (contextt,state){
              bloc = BlocProvider.of<MenuBloc>(context);
              state = bloc.state;
              log("build:"+state.toString());
              if(state is BooksState){
                return Books();
              }else if(state is AuthorsState){
                return Authors();
              }else if(state is LoansState){
                return Loans();
              }else{
                return Container();
              }
            },
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.blue),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: changePage,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("Kitaplar")),
              BottomNavigationBarItem(icon: Icon(Icons.account_box_sharp),title: Text("Yazarlar")),
              BottomNavigationBarItem(icon: Icon(Icons.local_library),title: Text("Ödünç alınanlar"))
            ],
          ),
        )
      );*/
/*return Scaffold(
      appBar: AppBar(title: Text("Kütüphane"),),
     // body: pages(index),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.blue),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: changePage,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("Kitaplar")),
            BottomNavigationBarItem(icon: Icon(Icons.account_box_sharp),title: Text("Yazarlar")),
            BottomNavigationBarItem(icon: Icon(Icons.local_library),title: Text("Ödünç alınanlar"))
          ],
        ),
      ),
    );*/