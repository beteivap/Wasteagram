import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/retrieve_location.dart';
import '../models/food_waste_post.dart';

class WastedFoodForm extends StatefulWidget {
  final String imageURL;
  const WastedFoodForm({ Key? key, required this.imageURL }) : super(key: key);

  @override
  _WastedFoodFormState createState() => _WastedFoodFormState();
}

class _WastedFoodFormState extends State<WastedFoodForm> {

  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> foodWasteMap = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Semantics(
            label: 'Number of wasted items input field',
            enabled: true,
            textField: true,
            onTapHint: 'Enter number of wasted items',
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Number of Wasted Items',
              ),
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onSaved: (value) {
                foodWasteMap['quantity'] = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a number!';
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Semantics(
              label: 'Upload button',
              button: true,
              enabled: true,
              onTapHint: 'Uploading image',
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    foodWasteMap['date'] = DateTime.now();
                    final locationData = await retrieveLocation();
                    foodWasteMap['longitude'] = locationData.longitude;
                    foodWasteMap['latitude'] = locationData.latitude;
                    foodWasteMap['imageURL'] = widget.imageURL;
                    uploadData(FoodWastePost.fromMap(foodWasteMap));
                    Navigator.of(context).pop();
                  }
                }, 
                child: const Icon(
                  Icons.cloud_upload,
                  size: 100,
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  void uploadData(FoodWastePost foodWastePost) async {
    FirebaseFirestore.instance.collection('posts').add(
      {'date': foodWastePost.date, 
      'quantity': foodWastePost.quantity, 
      'imageURL': foodWastePost.imageURL,
      'latitude': foodWastePost.latitude,
      'longitude': foodWastePost.longitude}
    );
  }
}
