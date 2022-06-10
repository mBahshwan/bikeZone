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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text("المستأجرين الحاليين"),
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
                      Text(":رقم هاتف العميل"),
                      Text(":اسم المستأجر")
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
                              "${currentRenter[i]['kidzCycles']} : (صغار) عدد الدراجات")),
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Text(
                              "${currentRenter[i]['adultCycles']}  : (كبار)عدد الدراجات ")),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text(
                                        "هل انت متأكد من انك تريد الحذف",
                                      ),
                                      title: Text(
                                          "ملاحظه : اذا ضغطت على نعم سيتم حذف ${currentRenter[i]["name"]}  صاحب الرقم لهاتف ${currentRenter[i]["phone"]}",
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
                      Text(":المده المستأجره "),
                      Text(":وقت دخول العميل ")
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
