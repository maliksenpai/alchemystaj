import 'dart:developer';

import 'package:alchemy_staj3/bloc/date/dateBloc.dart';
import 'package:alchemy_staj3/bloc/date/dateEvent.dart';
import 'package:alchemy_staj3/bloc/date/dateState.dart';
import 'package:alchemy_staj3/data/api/dates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DatePage();
}

class _DatePage extends State<DatePage> {
  DateBloc bloc;
  int radioid=0;
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  bool nameValidate = false;
  bool surnameValidate = false;
  bool mailValidate = false;
  bool numberValidate = false;
  bool checkbutton = false;
  bool checkdate = true;
  DateTime dateTime = new DateTime(0);

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<DateBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Randevu al"),
      ),
      body: SafeArea(
        child: BlocConsumer<DateBloc, DateState>(
          cubit: bloc,
          listener: (context, state) {
            state = bloc.state;
            log("lis"+bloc.state.toString());
            if (state is InitState) {
              return GetDate();
            } else if (state is CompletedState) {
              return Completed();
            } else if (state is FailedState) {
              return Failed();
            }
          },
          builder: (context, state) {
            state = bloc.state;
            log("buil"+bloc.state.toString());
            if (state is InitState) {
              return GetDate();
            } else if (state is CompletedState) {
              return Completed();
            } else if (state is FailedState) {
              return Failed();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget GetDate() {
    return Center(
      child: Column(
        children: [
          Column(
            children: [
                RadioListTile(
                    value: 0,
                    title: Text("A Testi"),
                    groupValue: radioid,
                    onChanged: (val) => changeRadioButton(val)
                ),
                RadioListTile(
                    value: 1,
                    title: Text("B Testi"),
                    groupValue: radioid,
                    onChanged: (val) => changeRadioButton(val)
                ),

              ],
            ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: "İsim",
                errorText: nameValidate ? "Boş bırakmayın" : null),
          ),
          TextField(
            controller: surnameController,
            decoration: InputDecoration(
                labelText: "Soyisim",
                errorText: surnameValidate ? "Boş bırakmayın" : null),
          ),
          TextField(
            controller: mailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "Mail",
                errorText: mailValidate ? "Boş bırakmayın" : null),
          ),
          TextField(
            controller: numberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Number",
                errorText: numberValidate ? "Boş bırakmayın" : null),
          ),
          RaisedButton(
            onPressed: () => selectDateTime(),
            child: Text("Randevu için tarih seçin"),
          ),
          checkdate
              ? Container()
              : Text(
                  "Seçilen randevu saati dolu lütfen başka tarihi deneyin",
                  style: TextStyle(color: Colors.red),
                ),
          dateTime.year == 0
              ? Container()
              : Text("Seçilen tarih: " +
                  dateTime.year.toString() +
                  "/" +
                  dateTime.month.toString() +
                  "/" +
                  dateTime.minute.toString() +
                  "-" +
                  dateTime.hour.toString() +
                  ":" +
                  dateTime.minute.toString()),
          RaisedButton(
            onPressed: checkbutton & checkdate ? () => sendDate() : null,
            child: Text("Gönder"),
            color: checkbutton & checkdate ? Colors.blue : Colors.grey,
          )
        ],
      ),
    );
  }


  Widget Completed() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
            size: 100,
          ),
          Text("Başarılı"),
          Text("Randevu tarihi: " +
              dateTime.year.toString() +
              "/" +
              dateTime.month.toString() +
              "/" +
              dateTime.minute.toString() +
              "-" +
              dateTime.hour.toString() +
              ":" +
              dateTime.minute.toString()),
          RaisedButton(
            child: Text("Menuye Dön"),
            onPressed: () {
              bloc.add(Finish());
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget Failed() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.clear,
            color: Colors.red,
            size: 100,
          ),
          Text("İşlem başarısız oldu"),
          RaisedButton(
            child: Text("Menuye Dön"),
            onPressed: () {
              bloc.add(Finish());
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }


  selectDateTime() {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 9, 9),
        maxTime: DateTime(2030, 12, 31),
        locale: LocaleType.tr,
        currentTime: DateTime.now(), onConfirm: (date) {
          dateTime = date;

          setState(() {
            checkdate = true;
            var dates = Dates().dates;
            dates.forEach((element) {
              log(element.time.toString() + "-" + dateTime.toString());
              if (element.time.year == dateTime.year &&
                  element.time.month == dateTime.month &&
                  element.time.day == dateTime.day &&
                  element.time.hour == dateTime.hour &&
                  element.time.minute == dateTime.minute) {
                checkdate = false;
              }
            });
            log(checkdate.toString());
            checkbutton = true;
          });
        });
  }

  sendDate() {
    if(nameController.text.isEmpty){
      setState(() {
        nameValidate=true;
        surnameValidate=false;
        mailValidate=false;
        numberValidate=false;
      });
      return;
    }
    if(surnameController.text.isEmpty){
      setState(() {
        nameValidate=false;
        surnameValidate=true;
        mailValidate=false;
        numberValidate=false;
      });
      return;
    }
    if(mailController.text.isEmpty){
      setState(() {
        nameValidate=false;
        surnameValidate=false;
        mailValidate=true;
        numberValidate=false;
      });
      return;
    }
    if(numberController.text.isEmpty){
      setState(() {
        nameValidate=false;
        surnameValidate=false;
        mailValidate=false;
        numberValidate=true;
      });
      return;
    }

    if(radioid==0){
      bloc.add(NewDateA(
          time: dateTime,
          name: nameController.text,
          surname: surnameController.text,
          mail: mailController.text,
          number: numberController.text));
    }else if(radioid==1){
      bloc.add(NewDateB(
          time: dateTime,
          name: nameController.text,
          surname: surnameController.text,
          mail: mailController.text,
          number: numberController.text));
    }
  }

  changeRadioButton(int val){
    setState(() {
      radioid = val;
    });
  }

}
