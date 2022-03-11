import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Verify post created from Map has appropriate property values.', () {
    final date = DateTime.parse('2020-01-01');
    const imageURL = 'www.flutter.io';
    const quantity = 5;
    const latitude = -12.712;
    const longitude = 0.172;

    final foodWastePost = FoodWastePost.fromMap({
      'date': date,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    expect(foodWastePost.date, date);
    expect(foodWastePost.imageURL, imageURL);
    expect(foodWastePost.quantity, quantity.toString());
    expect(foodWastePost.latitude, latitude.toString());
    expect(foodWastePost.longitude, longitude.toString());
  });

  test('Verify post\'s quantity, latitude, longitude properties are converted to strings.', () {
    final date = DateTime.parse('2020-01-01');
    const imageURL = 'www.flutter.io';
    const quantity = 5;
    const latitude = -12.712;
    const longitude = 0.172;

    final foodWastePost = FoodWastePost.fromMap({
      'date': date,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    expect(foodWastePost.quantity, const TypeMatcher<String>());
    expect(foodWastePost.latitude, const TypeMatcher<String>());
    expect(foodWastePost.longitude, const TypeMatcher<String>());
  });
}
