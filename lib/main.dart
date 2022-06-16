import 'package:bike_zoon_app/components/appLocal.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? mySharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  mySharedPreferences = await SharedPreferences.getInstance();
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
        localizationsDelegates: [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale("en", ""), Locale("ar", "")],
        localeResolutionCallback: (currentLang, supportLang) {
          if (currentLang != null) {
            for (Locale locale in supportLang) {
              if (locale.languageCode == currentLang.languageCode) {
                mySharedPreferences!
                    .setString("lang", currentLang.languageCode);

                return currentLang;
              }
            }
          }
          return supportLang.first;
        },
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
