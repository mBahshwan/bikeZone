import 'package:bike_zoon_app/components/appLocal.dart';
import 'package:bike_zoon_app/widgets/signatureHere.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CustomerInformation extends StatefulWidget {
  final List<Map>? customerTitle;
  final String? id;
  const CustomerInformation({
    Key? key,
    this.id,
    this.customerTitle,
  }) : super(key: key);

  @override
  State<CustomerInformation> createState() => _CustomerInformationState();
}

class _CustomerInformationState extends State<CustomerInformation> {
  Future showCustomerDetails() async {
    List<Map> response = await sqlDb.readData('''
          SELECT DISTINCT name, id, phone, time FROM clients WHERE id = ${widget.id}
     ''');
    return response;
  }

  showCustomerHowManyTimesCame() async {
    int howManyTimeCustomerCame = await sqlDb.getCount("${widget.id}");
    return howManyTimeCustomerCame;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: showCustomerDetails(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) => Card(
                margin: EdgeInsets.all(10),
                child: (Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${getLang(context, "customer number")}",
                        ),
                        Text("${getLang(context, "customer name")} "),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 50),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            " ${snapshot.data[i]['phone']}",
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          height: 40,
                          width: 80,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text("${snapshot.data[i]['name']}"),
                          decoration: BoxDecoration(border: Border.all()),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Text(
                            "${getLang(context, "customer id")} ",
                          ),
                        ),
                        Container(
                            child: Text(
                                "${getLang(context, "number of visits")} ")),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 50),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${snapshot.data[i]['id']}",
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 50),
                            padding: EdgeInsets.all(10),
                            child: FutureBuilder(
                              future: showCustomerHowManyTimesCame(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text("${snapshot.data}");
                                }
                                return Container();
                              },
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text("${getLang(context, "customer visit date")} "),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(border: Border.all()),
                        height: 35,
                        width: 130,
                        child: Text(
                            "${Jiffy(snapshot.data[i]['time']).format("y/M/d")}")),
                  ],
                )),
              ),
            );
          }
          return Center(child: Text("Loading .../"));
        });
  }
}
