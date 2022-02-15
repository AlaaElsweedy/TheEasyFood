class MealModel {
  String? mealId;
  String? title;
  dynamic price;
  String? description;
  //int? quantity;
  String? category;
  String? image;
  String? duration;
  bool? isFavorite;
  //bool? inCart;
  // bool? isGlutenFree;
  // bool? isLactoseFree;
  // bool? isVegetarian;

  MealModel({
    required this.mealId,
    required this.title,
    required this.price,
    required this.description,
    //required this.quantity,
    required this.category,
    required this.image,
    required this.duration,
    required this.isFavorite,
    //required this.inCart,
    // required this.isGlutenFree,
    // required this.isLactoseFree,
    // required this.isVegetarian,
  });

  MealModel.fromJson(Map<String, dynamic> json) {
    mealId = json['mealId'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    //quantity = json['quantity'];
    category = json['category'];
    image = json['image'];
    duration = json['duration'];
    isFavorite = json['isFavorite'];
    //inCart = json['inCart'];
    // isGlutenFree = json['isGlutenFree'];
    // isLactoseFree = json['isLactoseFree'];
    // isVegetarian = json['isVegetarian'];
  }

  Map<String, dynamic> toMap() {
    return {
      'mealId': mealId,
      'title': title,
      'price': price,
      'description': description,
      //'quantity': quantity,

      'category': category,
      'image': image,
      'duration': duration,
      'isFavorite': isFavorite,
      //'inCart': inCart,
      // 'isGlutenFree': isGlutenFree,
      // 'isLactoseFree': isLactoseFree,
      // 'isVegetarian': isVegetarian,
    };
  }
}
