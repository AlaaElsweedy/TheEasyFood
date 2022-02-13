class CartModel {
  late String title, image, mealId;
  dynamic price;
  late int quantity;

  CartModel({
    required this.title,
    required this.image,
    required this.price,
    required this.mealId,
    required this.quantity,
  });

  CartModel.fromJson(Map<dynamic, dynamic> map) {
    title = map['title'];
    image = map['image'];
    price = map['price'];
    mealId = map['mealId'];
    quantity = map['quantity'];
  }

  toJson() {
    return {
      'title': title,
      'image': image,
      'price': price,
      'mealId': mealId,
      'quantity': quantity,
    };
  }
}
