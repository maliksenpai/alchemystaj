import 'dart:async';

class LoginValidator{
  final namevalidator = new StreamTransformer<String,String>.fromHandlers(
    handleData:(name,sink){
      if(name.length<3){
        sink.add("Kısa isim");
      }else{
        sink.add(name);
      }
    }
  );

  final surnamevalidator = new StreamTransformer<String,String>.fromHandlers(
      handleData:(name,sink){
        if(name.length<3){
          sink.add("Kısa soyisim");
        }else{
          sink.add(name);
        }
      }
  );
}