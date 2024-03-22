import 'package:flutter/cupertino.dart';

class Bill{

  String? name;
  double? price;
  int? quantity;
  List<Bill>? productList;

  Bill({this.name, this.price, this.quantity, this.productList});

  factory Bill.getData(Map map){
    return Bill(name: map['name'], price: map['price'], quantity: map['quantity']);
  }


  refreshData(){
    productList = data.map((e) => Bill.getData(e)).toList();
  }


  var txtName = TextEditingController();
  var txtPrice = TextEditingController();
  var txtQuantity = TextEditingController();

}

List data = [];