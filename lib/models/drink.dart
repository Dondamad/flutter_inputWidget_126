class Drink {
  String? thName;
  int? price;
  bool? checked;

  //Constructor
  Drink(this.thName, this.price, this.checked);

  static getDrink() {
    return [
      Drink('โกโก้', 20, false),
      Drink('ชานมไข่มุก', 30, false),
      Drink('สตอร์เบอร์รี', 50, false),
    ];
  }
}
