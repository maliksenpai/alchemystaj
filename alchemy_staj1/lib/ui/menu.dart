import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/bloc/menuBloc.dart';
import 'package:alchemy_staj1/bloc/userBloc.dart';
import 'package:alchemy_staj1/model/author.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:alchemy_staj1/model/loans.dart';
import 'package:alchemy_staj1/ui/bookdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Menu",
      home: BlocProviderr(
        child: _MenuPage(),
        bloc: MenuBloc(),
      )
    );
  }
}

class _MenuPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MenuPage();
  }
}

class MenuPage extends State<_MenuPage>{
  int index=0;
  MenuBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProviderr.of<MenuBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Kütüphane"),),
      body: pages(index),
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
    );
  }

  void changePage(int i){
    setState(() {
      index=i;
    });
  }

  Widget pages(int i){
    if(index==0){
      return Books();
    }else if(index==1){
      return Authors();
    }else{
      return Loans();
    }
  }

  Widget Books(){
    bloc.init();
    return StreamBuilder(
        stream: bloc.bookstream,
        builder: (BuildContext context,AsyncSnapshot<List<Book>> snapshot){
          var list = snapshot.data;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetail()));},
                title: Text(list[index].name),
                trailing: list[index].isAvailable ? Text("Kiralanabilir",style: TextStyle(color: Colors.green),) : Text("Şuan kiralanamaz",style: TextStyle(color: Colors.red),),
                subtitle: Text("Sayfa sayısı:"+list[index].pageCount.toString()),
              );
            },
          );
        },
    );
  }

  Widget Authors(){
    bloc.init();

    return StreamBuilder(
      stream: bloc.authorstream,
      builder: (BuildContext context,AsyncSnapshot<List<Author>> snapshot){
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
      },
    );
  }

  Widget Loans(){
    bloc.init();

    return StreamBuilder(
      stream: bloc.loanstream,
      builder: (BuildContext context,AsyncSnapshot<List<Loan>> snapshot){
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
      },
    );
  }

}