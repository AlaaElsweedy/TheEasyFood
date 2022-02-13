import 'cart_model.dart';

class OrderModel {
  late final String id;
  late final String dateTime;
  late final dynamic total;
  late List<CartModel> cartItem = [];

  OrderModel({
    required this.id,
    required this.dateTime,
    required this.total,
    required this.cartItem,
  });

  OrderModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    dateTime = json['dateTime'];
    total = json['total'];
    json['cartItem'].forEach((element) {
      cartItem.add(CartModel.fromJson(element));
    });
  }

  toJson() {
    return {
      'id': id,
      'dateTime': dateTime,
      'total': total,
      'cartItem': cartItem.map((v) => v.toJson()).toList(),
    };
  }
}

// class DataModel {
//   late int mealId;
//   late String name;
//   late String image;
//   late dynamic price;
//   late String title;
//   late int quantity;

//   DataModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     image = json['image'];
//     price = json['price'];
//     mealId = json['mealId'];
//     quantity = json['quantity'];
//   }
// }
