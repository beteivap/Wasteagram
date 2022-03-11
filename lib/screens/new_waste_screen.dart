import 'package:flutter/material.dart';
import '../widgets/wasted_food_form.dart';

class NewWasteScreen extends StatefulWidget {
  const NewWasteScreen({ Key? key}) : super(key: key);

  static const routeName = 'newWaste';

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {
  @override
  Widget build(BuildContext context) {

    final List args = ModalRoute.of(context)?.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            SizedBox(
              height: 300,
              width: 400,
              child: Semantics(
                child: Image.file(args[0]),
                image: true,
                label: 'Photo of food waste',
                readOnly: true,
                enabled: true,
              ),
            ),
            const SizedBox(height: 10),
            WastedFoodForm(imageURL: args[1]),
          ],
        ),
      )
    );
  }
}