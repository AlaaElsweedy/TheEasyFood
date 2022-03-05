class RestaurantModel {
  String? uId;
  String? name;

  String? image;

  RestaurantModel({
    required this.uId,
    required this.name,
    required this.image,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
    };
  }
}
