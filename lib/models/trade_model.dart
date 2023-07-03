class Trade {
  final int? id;
  final String type;
  final double price;
  final String? exitPrice;
  final double quantity;
  final String date;
  final String time;
  final int? marketId;

  Trade({
    this.id,
    required this.type,
    this.exitPrice,
    required this.price,
    required this.quantity,
    required this.date,
    required this.time,
    this.marketId,
  });

  // Convert Trade object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'price': price,
      'exitPrice': exitPrice,
      'quantity': quantity,
      'date': date,
      'time': time,
      'marketId': marketId,
    };
  }

  // Create a Trade object from a JSON Map
  static Trade fromJson(Map<String, dynamic> json) {
    return Trade(
      id: json['id'],
      type: json['type'],
      price: json['price'],
      exitPrice: json['exitPrice'],
      quantity: json['quantity'],
      date: json['date'],
      time: json['time'],
      marketId: json['marketId'],
    );
  }
}
