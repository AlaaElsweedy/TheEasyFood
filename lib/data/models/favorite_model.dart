class FavoriteModel {
  late String productId;
  late String title;
  late String image;
  late dynamic price;

  FavoriteModel({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'price': price,
    };
  }
}
