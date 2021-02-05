import 'dart:developer';

import 'package:alchemy_staj3/bloc/reservation/reservationBloc.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationEvent.dart';
import 'package:alchemy_staj3/data/persons.dart';
import 'package:alchemy_staj3/model/l_product.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddDate();
}

class _AddDate extends State<AddDate> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController surnamecontroller = new TextEditingController();
  TextEditingController addresscontroller = new TextEditingController();

  //ülke listesi
  TextEditingController zipcodecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();
  Salutation salutation = Salutation.man;
  TextEditingController idcontroller = new TextEditingController();
  List<String> countries = ['Turkey', 'Germany', 'England'];
  String selectedCountry = 'Turkey';

  bool namevalidate = false;
  bool surnamevalidate = false;
  bool addressvalidate = false;
  bool zipvalidate = false;
  bool mailvalidate = false;
  bool phonevalidate = false;
  bool idvalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).randevuIcinKisiEkle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).isim,
                    errorText: namevalidate ? AppLocalizations.of(context).bosBirakma: null),
              )),
              SizedBox(
                width: 40,
              ),
              Flexible(
                child: TextField(
                  controller: surnamecontroller,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).soyisim,
                      errorText: surnamevalidate ? AppLocalizations.of(context).bosBirakma:null),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              DropdownButton(
                value: selectedCountry,
                icon: Icon(Icons.arrow_drop_down),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (String value) {
                  setState(() {
                    selectedCountry = value;
                  });
                },
                items: countries.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem<String>(value: e, child: Text(e));
                }).toList(),
              ),
              SizedBox(
                width: 40,
              ),
              Flexible(
                child: TextField(
                  controller: zipcodecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).zipKodu,
                    errorText: zipvalidate ? AppLocalizations.of(context).bosBirakma:null
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: addresscontroller,
            decoration:
                InputDecoration(
                  labelText: AppLocalizations.of(context).adres,
                  errorText: addressvalidate ? AppLocalizations.of(context).bosBirakma : null
                ),
          ),
          TextField(
            controller: mailcontroller,
            decoration:
            InputDecoration(
                labelText: AppLocalizations.of(context).mail,
                errorText: mailvalidate ? AppLocalizations.of(context).bosBirakma : null
            ),
          ),
          TextField(
            controller: phonecontroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context).telefonNumarasi,
                errorText: phonevalidate ? AppLocalizations.of(context).bosBirakma : null
            ),
          ),
          Container(
            height: 10,
          ),
          Text(AppLocalizations.of(context).cinsiyetSec),
          Row(
            children: [
              Flexible(
                child: RadioListTile(
                  value: Salutation.man,
                  title: Text(AppLocalizations.of(context).erkek),
                  groupValue: salutation,
                  onChanged: (Salutation value) => {
                    setState(() {
                      salutation = Salutation.man;
                    })
                  },
                ),
              ),
              Flexible(
                child: RadioListTile(
                  value: Salutation.woman,
                  title: Text(AppLocalizations.of(context).kadin),
                  groupValue: salutation,
                  onChanged: (value) => {
                    setState(() {
                      salutation = Salutation.woman;
                    })
                  },
                ),
              )
            ],
          ),
          TextField(
            controller: idcontroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).kimlikNumarasi,
              errorText: idvalidate ? AppLocalizations.of(context).bosBirakma:null
            ),
          ),
          RaisedButton(
            onPressed: () => addPerson(),
            child: Text(AppLocalizations.of(context).kisiyiEkle),
          )
        ],
      ),
    );
  }

  addPerson(){
    log("asd");
    if(namecontroller.text.length==0){
      log("1");
      setState(() {
        namevalidate=true;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
      });
    }else if(surnamecontroller.text.length==0){
      log("2");
      setState(() {
        namevalidate=false;
        surnamevalidate=true;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
      });
    }else if(addresscontroller.text.length==0){
      log("3");
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=true;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
      });
    }else if(mailcontroller.text.length==0){
      log("4");
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=true;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
      });
    }else if(zipcodecontroller.text.length==0){
      log("5");
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=true;
        phonevalidate=false;
        idvalidate=false;
      });
    }else if(phonecontroller.text.length==0){
      log("6");
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=true;
        idvalidate=false;
      });
    }else if(idcontroller.text.length==0){
      log("7");
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=true;
      });
    }else{

      var person = Person(
        id: 1,
        first_name: namecontroller.text,
        surname: surnamecontroller.text,
        address: addresscontroller.text,
        email: mailcontroller.text,
        zipcode: zipcodecontroller.text,
        phone_gsm: phonecontroller.text,
        salutation: salutation,
        tc_kimlik: idcontroller.text,
        products: List<L_Product>()
      );
      ReservationBloc bloc = BlocProvider.of(context);
      bloc.add(AddPerson(person: person));
      Navigator.pop(context);
    }
  }
}
