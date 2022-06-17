import 'package:bike_zoon_app/classes/languages.dart';
import 'package:bike_zoon_app/main.dart';
import 'package:bike_zoon_app/widgets/mainScreenWidget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _changeLanguage(Language language) async {
    Locale _temp;
    switch (language.languageCode) {
      case 'ar':
        _temp = Locale(language.languageCode, "SA");
        break;
      case 'en':
        _temp = Locale(language.languageCode, "US");
        break;
      default:
        _temp = Locale(language.languageCode, "SA");
    }
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                onChanged: (Language? language) {
                  _changeLanguage(language!);
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[400],
        body: MainScreenWidget());
  }
}
