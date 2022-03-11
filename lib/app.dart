import 'package:flutter/material.dart';
import 'screens/new_waste_screen.dart';
import 'screens/waste_detail_screen.dart';
import 'screens/waste_list_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final routes = {
      WasteListScreen.routeName: (context) =>  const WasteListScreen(),
      WasteDetailScreen.routeName: (context) => const WasteDetailScreen(),
      NewWasteScreen.routeName: (context) => const NewWasteScreen()
    };

    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}
