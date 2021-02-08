import 'dart:developer';

import 'package:alchemy_staj3/bloc/reservation/reservationBloc.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationEvent.dart';
import 'package:alchemy_staj3/data/persons.dart';
import 'package:alchemy_staj3/model/e_order.dart';
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
  bool privacy_policy=false;
  bool service_policy=false;
  List<String> countries = ['Turkey', 'Germany', 'England'];
  String selectedCountry = 'Turkey';

  bool namevalidate = false;
  bool surnamevalidate = false;
  bool addressvalidate = false;
  bool zipvalidate = false;
  bool mailvalidate = false;
  bool phonevalidate = false;
  bool idvalidate = false;
  bool privacyvalidate = false;
  bool servicevalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).randevuIcinKisiEkle),
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
                  child:TextField(
                    controller: zipcodecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).zipKodu,
                        errorText: zipvalidate ? AppLocalizations.of(context).bosBirakma:null
                    ),
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: addresscontroller,
                decoration:
                InputDecoration(
                    labelText: AppLocalizations.of(context).adres,
                    errorText: addressvalidate ? AppLocalizations.of(context).bosBirakma : null
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: mailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration:
                InputDecoration(
                    labelText: AppLocalizations.of(context).mail,
                    errorText: mailvalidate ? AppLocalizations.of(context).bosBirakma : null
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: phonecontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).telefonNumarasi,
                    errorText: phonevalidate ? AppLocalizations.of(context).bosBirakma : null
                ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: idcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).kimlikNumarasi,
                    errorText: idvalidate ? AppLocalizations.of(context).bosBirakma:null
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CheckboxListTile(
                      //buraya bi ontap ile ekran açıp sözleşmeyi anlatcaz
                      title: Text("Gizlilik Sözleşmesini Kabul ediyorum"),
                      value: privacy_policy,
                      onChanged: (value){
                        setState(() {
                          privacy_policy=value;
                        });
                      },
                    ),
                    privacyvalidate ? Text("Gizlilik sözleşmesini kabul etmelisiniz!",style: TextStyle(color: Colors.redAccent),) : Container()
                  ],
                )
            ),
            Padding(
                padding:EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CheckboxListTile(
                      //buraya bi ontap ile ekran açıp sözleşmeyi anlatcaz
                      title: Text("Servis sözleşmesini Kabul ediyorum"),
                      value: service_policy,
                      onChanged: (value){
                        setState(() {
                          service_policy=value;
                        });
                      },
                    ),
                    servicevalidate ? Text("Servis sözleşmesini kabul etmelisiniz!",style: TextStyle(color: Colors.redAccent),) : Container()
                  ],
                )
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: () => addPerson(),
              child: Text(AppLocalizations.of(context).kisiyiEkle),
            )
          ],
        ),
      )
    );
  }

  addPerson(){
    if(namecontroller.text.length==0){
      setState(() {
        namevalidate=true;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
        privacyvalidate=false;
        servicevalidate=false;
      });
    }else if(surnamecontroller.text.length==0){
      setState(() {
        namevalidate=false;
        surnamevalidate=true;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
        privacyvalidate=false;
        servicevalidate=false;
      });
    }else if(addresscontroller.text.length==0){
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=true;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
        privacyvalidate=false;
        servicevalidate=false;
      });
    }else if(mailcontroller.text.length==0){
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=true;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
        privacyvalidate=false;
        servicevalidate=false;
      });
    }else if(zipcodecontroller.text.length==0){
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=true;
        phonevalidate=false;
        idvalidate=false;
        privacyvalidate=false;
        servicevalidate=false;
      });
    }else if(phonecontroller.text.length==0){
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=true;
        idvalidate=false;
        privacyvalidate=false;
        servicevalidate=false;
      });
    }else if(idcontroller.text.length==0){
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=true;
        privacyvalidate=false;
        servicevalidate=false;
      });
    }else if(!privacy_policy){
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
        privacyvalidate=true;
        servicevalidate=false;
      });
    }else if(!service_policy){
      setState(() {
        namevalidate=false;
        surnamevalidate=false;
        addressvalidate=false;
        mailvalidate=false;
        zipvalidate=false;
        phonevalidate=false;
        idvalidate=false;
        privacyvalidate=false;
        servicevalidate=true;
      });
    }else{
      var id = Persons().e_order_id;
      bool contactPerson = false;
      if(Persons().reservationInfo.length==0){
        contactPerson=true;
      }
      var person = Person(
        id: id,
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
      var e_order = e_Order(
        id: id,
        is_contact_person: contactPerson,
        person_id: id,person: person,
        is_accepted_privary_policy: true,
        is_accepted_service_policy: true
      );
      id++;
      Persons().e_order_id=id;
      ReservationBloc bloc = BlocProvider.of(context);
      bloc.add(AddPerson(person: e_order));
      Navigator.pop(context);
    }
  }
}
