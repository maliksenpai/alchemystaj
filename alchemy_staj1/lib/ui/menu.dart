import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/bloc/menuBloc.dart';
import 'package:alchemy_staj1/bloc/userBloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("asd"),),
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
    return Text("Books");
  }

  Widget Authors(){
    return Text("Authors");

  }

  Widget Loans(){
    return Text("Loans");
  }
}