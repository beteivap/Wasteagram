import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WasteDetailScreen extends StatelessWidget {
  const WasteDetailScreen({ Key? key }) : super(key: key);

  static const routeName = 'wasteDetail';

  @override
  Widget build(BuildContext context) {

     List args = ModalRoute.of(context)?.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                DateFormat('EEEE, MMMM dd, yyyy').format(args[0].toDate()),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 300,
                width: 400,
                child: Semantics(
                  child: Image.network(args[2]),
                  image: true,
                  label: 'Photo of food waste',
                  readOnly: true,
                  enabled: true,
                ),
              ),
              const SizedBox(height: 100),
              Text(
                '${args[1]} items',
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 100),
              Text(
                'Location: (${args[3]}, ${args[4]})',
                style: const TextStyle(fontSize: 18)
              )
            ],
          ),
        ),
      )
    );
  }
}