import 'package:bike_zoon_app/components/appLocal.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 6,
            childAspectRatio: 1,
            crossAxisSpacing: 6,
          ),
          children: [
            InkWell(
                onTap: (() {
                  Navigator.of(context).pushNamed("agrementScreen");
                  // removeDataBase();
                }),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          )),
                      child: Image.asset(
                        "images/makeRent.jpg",
                        width: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${getLang(context, "create rent agrement")} ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            InkWell(
                onTap: (() {
                  Navigator.of(context).pushNamed("showData");
                }),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.group,
                          size: 100,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${getLang(context, "show customers")} ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            InkWell(
                onTap: (() {
                  Navigator.of(context).pushNamed("currentRentrs");
                }),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          )),
                      child: Image.asset(
                        "images/byCycl.jpg",
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${getLang(context, "current renters")} ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textDirection: TextDirection.ltr),
                    ),
                  ],
                )),
          ]),
    );
  }
}
