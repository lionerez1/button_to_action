import 'package:button_to_action/viewmodels/HomeScreenViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/HomeScreen.dart';

void main() async {
  final MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  final MyHomePage homePage = MyHomePage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ButtonToAction',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeScreenViewModel())
        ],
        child: MyHomePage(),
      ),
    );
  }
}
