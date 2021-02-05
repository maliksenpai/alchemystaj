enum Type_State{
  Randevu_Yok,Test_Yapilmaya_Gidilecek,Test_Calisiliyor,Sonuc_Cikti
}

class e_Order_Details {
  int id;
  int code_number;
  int e_order_person_id;
  int l_product_id;
  int slot_id;
  double amount;
  double discount_percent;
  double discount_amount;
  bool test_result;
  Type_State type_state;
  String pdf_download_link;

  e_Order_Details({
    this.id,
    this.code_number,
    this.e_order_person_id,
    this.l_product_id,
    this.slot_id,
    this.amount,
    this.discount_percent,
    this.discount_amount,
    this.test_result,
    this.type_state,
    this.pdf_download_link
  });

  
}