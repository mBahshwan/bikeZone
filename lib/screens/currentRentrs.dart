import 'package:bike_zoon_app/components/appLocal.dart';
import 'package:bike_zoon_app/database/sqlflite.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CurrentRentrs extends StatefulWidget {
  const CurrentRentrs({Key? key}) : super(key: key);

  @override
  State<CurrentRentrs> createState() => _CurrentRentrsState();
}

class _CurrentRentrsState extends State<CurrentRentrs> {
  SqlDb sqlDb = SqlDb();

  List<Map> currentRenter = [];
  void getCurrentRenters() async {
    List<Map> response = await sqlDb.readData(
        "SELECT DISTINCT name, phone, id, kidzCycles, adultCycles, duration, time FROM currentClients  ");
    setState(() {
      currentRenter.addAll(response);
    });
  }

  @override
  void initState() {
    getCurrentRenters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text("${getLang(context, "current renters")} "),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back))),
      body: ListView.builder(
        itemCount: currentRenter.length,
        itemBuilder: (context, i) {
          String customerComingTime =
              Jiffy("${currentRenter[i]["time"]}").format("h : m : s");

          return Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("${getLang(context, "customer number")}"),
                      Text("${getLang(context, "customer name")} ")
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Text("${currentRenter[i]['phone']}")),
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Text("${currentRenter[i]['name']}")),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Text(
                              "${currentRenter[i]['kidzCycles']} : ${getLang(context, "how many kidz bicycle")} ")),
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Text(
                              "${currentRenter[i]['adultCycles']}  :${getLang(context, "how many adult bicycle")} ")),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text(
                                        "${getLang(context, "sure delete")} ",
                                      ),
                                      title: Text(
                                          "   ${getLang(context, "delete note1")}  ${currentRenter[i]["name"]}  ${getLang(context, "delete note2")}  ${currentRenter[i]["phone"]}",
                                          style: TextStyle(fontSize: 13)),
                                      actions: [
                                        IconButton(
                                            onPressed: () async {
                                              int response = await sqlDb.deleteData(
                                                  "DELETE FROM  currentClients WHERE phone = ${currentRenter[i]['phone']}");
                                              if (response > 0) {
                                                setState(() {
                                                  currentRenter.removeWhere(
                                                      (element) =>
                                                          element['phone'] ==
                                                          currentRenter[i]
                                                              ['phone']);
                                                });
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            icon: Icon(Icons.delete)),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.cancel))
                                      ],
                                    ));
                          },
                          icon: Icon(
                            Icons.circle,
                            size: 20,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("${getLang(context, "rent duration")} "),
                      Text("${getLang(context, "customer login time")} ")
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Text("${currentRenter[i]['duration']}")),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        alignment: Alignment.center,
                        height: 30,
                        width: 90,
                        child: Text("${customerComingTime}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
