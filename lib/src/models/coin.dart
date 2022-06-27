class Coin{
  String _symbol;
  double price;

  Coin(String symbol, String price){
   this.symbol = symbol;
   this.price = double.parse(price);
  }

  String get symbol => _symbol;

  set symbol(String value) {
    _symbol = value;
  }
}