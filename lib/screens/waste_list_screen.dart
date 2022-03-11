import 'package:flutter/material.dart';
import '../widgets/wasted_food_list.dart';

class WasteListScreen extends StatelessWidget {
  const WasteListScreen({ Key? key }) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: const WastedFoodList(),
    );
  }
}
