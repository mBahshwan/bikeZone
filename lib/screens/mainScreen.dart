import 'package:bike_zoon_app/database/sqlflite.dart';
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
      appBar: AppBar(title: Text("Bike Zone")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            children: [
              InkWell(
                  onTap: (() {
                    Navigator.of(context).pushNamed("agrementScreen");
                    // removeDataBase();
                  }),
                  child: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    child: Text("AGREMENT SCREEN"),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )),
              InkWell(
                  onTap: (() {
                    Navigator.of(context).pushNamed("showData");
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text("SHOW DATA"),
                  )),
              InkWell(
                  onTap: (() {
                    Navigator.of(context).pushNamed("currentRentrs");
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text("CURRENT RENTERS"),
                  )),
            ]),
      ),
    );
  }
}
