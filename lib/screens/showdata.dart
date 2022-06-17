import 'package:bike_zoon_app/components/appLocal.dart';
import 'package:bike_zoon_app/database/sqlflite.dart';
import 'package:bike_zoon_app/screens/customerDetails.dart';
import 'package:bike_zoon_app/screens/dataSearch.dart';

import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  final String? id;
  const ShowData({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  SqlDb sqlDb = SqlDb();

  List<Map> customerTitle = [];
  void getData() async {
    List<Map> response =
        await sqlDb.readData("SELECT DISTINCT phone, id, name FROM clients ");
    setState(() {
      customerTitle.addAll(response);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${getLang(context, "customer list")} "),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    useRootNavigator: true,
                    delegate: DataSearch(customerTitle));
              },
              icon: Icon(Icons.search)),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("mainScreen");
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
          itemCount: customerTitle.length,
          itemBuilder: ((context, i) => InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => CustomerDetails(
                                customerTitle: customerTitle,
                                id: "${customerTitle[i]['id']}",
                                cusomerName: "${customerTitle[i]['name']}",
                                customerPhoneNumber:
                                    "${customerTitle[i]['phone']}",
                              )),
                      (route) => false);
                  print("${widget.id}");
                },
                child: ListTile(
                  title: Text("${customerTitle[i]['name']}"),
                  subtitle: Text("${customerTitle[i]['id']}"),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(
                                      " ${getLang(context, "sure delete")}"),
                                  title: Text(
                                      " ${getLang(context, "delete note1")} ${customerTitle[i]['name']}",
                                      style: TextStyle(fontSize: 13)),
                                  actions: [
                                    IconButton(
                                        onPressed: () async {
                                          int response = await sqlDb.deleteData(
                                              "DELETE FROM clients WHERE id = ${customerTitle[i]['id']}");
                                          if (response > 0) {
                                            setState(() {
                                              customerTitle.removeWhere(
                                                  (element) =>
                                                      element['id'] ==
                                                      customerTitle[i]['id']);
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
                      icon: Icon(Icons.delete)),
                ),
              ))),
    );
  }
}
