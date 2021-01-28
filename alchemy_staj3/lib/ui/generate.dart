import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GeneratePage();


}

class _GeneratePage extends State<GeneratePage>{
  TextEditingController controller = new TextEditingController();
  String result="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("QR kod oluşturma"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              QrImage(size: 200,data: controller.text),
              TextField(
                controller: controller,
                onChanged: (text){
                  setState(() {
                    result = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Buraya yazın",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}