class UserModel {
  String? uId;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? image;
  String? bio;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.image,
    required this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'image': image,
      'bio': bio,
    };
  }
}
