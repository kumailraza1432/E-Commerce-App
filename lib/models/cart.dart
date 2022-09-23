class CartItems{
  late String productname;
  late String sellername;
  late String description;
  late double quantity;
  late int price;
  CartItems({required this.productname,required this.sellername,required this.description,required this.quantity,required this.price});
  List<CartItems> er = [];
  void addtolist(CartItems){
    er.add(CartItems);
    print('added');
    print(CartItems.price);
    print(CartItems.productname);
  }
  List<CartItems> items(){
    return er;
  }
}