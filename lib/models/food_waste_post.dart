class FoodWastePost {
  final DateTime date;
  final String quantity;
  final String latitude;
  final String longitude;
  final String imageURL;

  FoodWastePost(
    {required this.date, 
    required this.quantity, 
    required this.imageURL, 
    required this.latitude, 
    required this.longitude}
  );

  factory FoodWastePost.fromMap(Map<String, dynamic> foodWasteMap) {
    return FoodWastePost(
      date: foodWasteMap['date'], 
      quantity: foodWasteMap['quantity'].toString(), 
      imageURL: foodWasteMap['imageURL'], 
      latitude: foodWasteMap['latitude'].toString(), 
      longitude: foodWasteMap['longitude'].toString()
    );
  }
}
