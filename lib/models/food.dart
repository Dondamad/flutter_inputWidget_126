class Food {
  String? engName;
  String? thName;
  int? price;
  String? foodValue;

  //Constructor
  Food(this.engName, this.thName, this.price, this.foodValue);

  static getFood() {
    return [
      Food('Pizza', 'พิซซ่า', 99, 'pizza'),
      Food('Steak', 'สเต็ก', 199, 'steak'),
      Food('Shabu', 'ชาบู', 599, 'shabu'),
    ];
  }
}
