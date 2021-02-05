class Slot {
  int id;
  int l_company_id;
  String slot_date;
  String slot_start;
  String slot_time_end;
  int slot_time_period;
  bool active;
  int lock_user_id;
  String lock_time;

  Slot(
      {this.id,
      this.l_company_id,
      this.slot_date,
      this.slot_start,
      this.slot_time_end,
      this.slot_time_period,
      this.active,
      this.lock_time,
      this.lock_user_id});
}
