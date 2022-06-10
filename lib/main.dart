import 'dart:isolate';
import 'dart:ui';
import 'package:bike_zoon_app/providers/rentDuration.dart';
import 'package:bike_zoon_app/providers/howManyCycleSelected.dart';
import 'package:bike_zoon_app/screens/agrement_screen.dart';
import 'package:bike_zoon_app/screens/customerDetails.dart';
import 'package:bike_zoon_app/screens/mainScreen.dart';
import 'package:bike_zoon_app/screens/showdata.dart';
import 'package:bike_zoon_app/providers/totalPrice.dart';
import 'package:bike_zoon_app/screens/currentRentrs.dart';
import 'package:bike_zoon_app/widgets/testTimer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ReceivePort port = ReceivePort();
const String countKey = 'count';
const String isolateName = 'isolate';
SharedPreferences? prefs;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TotalPrice(),
        ),
        ChangeNotifierProvider(
          create: (context) => HowManyCycleSelectedAdult(),
        ),
        ChangeNotifierProvider(
          create: (context) => HowManyCycleSelectedKidz(),
        ),
        ChangeNotifierProvider(
          create: (context) => RentDuration(),
        ),
      ],
      child: MaterialApp(
        home: MainScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          "showData": (context) => ShowData(),
          "agrementScreen": (context) => AgrementScreen(),
          "mainScreen": (context) => MainScreen(),
          "customerDetails": (context) => CustomerDetails(),
          "currentRentrs": (context) => CurrentRentrs(),
          "testTimer": (context) => TestTimer(),
        },
      ),
    );
  }
}
