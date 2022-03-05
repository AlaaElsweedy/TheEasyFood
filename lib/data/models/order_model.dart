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
