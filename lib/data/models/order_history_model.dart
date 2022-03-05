class OrderHistoryModel {
  late dynamic totalPrice;
  late String dateTime;
  late String address;

  OrderHistoryModel({
    required this.totalPrice,
    required this.dateTime,
    required this.address,
  });

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    dateTime = json['dateTime'];
    address = json['address'];
  }

  Map<String, dynamic> toMap() {
    return {
      'totalPrice': totalPrice,
      'dateTime': dateTime,
      'address': address,
    };
  }
}
