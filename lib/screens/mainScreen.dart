import 'package:bike_zoon_app/widgets/mainScreenWidget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("BikeZone")),
        backgroundColor: Colors.blue[400],
        body: MainScreenWidget());
  }
}
