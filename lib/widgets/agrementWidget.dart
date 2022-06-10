import 'dart:typed_data';

import 'package:bike_zoon_app/database/sqlflite.dart';
import 'package:bike_zoon_app/providers/howManyCycleSelected.dart';
import 'package:bike_zoon_app/providers/rentDuration.dart';
import 'package:bike_zoon_app/screens/showdata.dart';
import 'package:bike_zoon_app/providers/totalPrice.dart';
import 'package:bike_zoon_app/widgets/conditionsAndTerms.dart';
import 'package:bike_zoon_app/widgets/howLong.dart';
import 'package:bike_zoon_app/widgets/howManyCycleAdult.dart';
import 'package:bike_zoon_app/widgets/howManyCycleKidz.dart';
import 'package:bike_zoon_app/widgets/signatureHere.dart';
import 'package:bike_zoon_app/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgrementWidget extends StatelessWidget {
  final TextEditingController? customerName;
  final TextEditingController? customerId;
  final TextEditingController? customerPhoneNumber;
  AgrementWidget(
      {Key? key, this.customerName, this.customerId, this.customerPhoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Conditions conditions = Conditions();

    SqlDb sqlDb = SqlDb();
    DateTime lastVisit;
    int howManyKidzCycles;
    int howManyAdultCycles;
    Object rentDuration;
    Uint8List? data;
    Image getSign;

    saveSignature() async {
      if (signatureController.isNotEmpty) {
        data = await signatureController.toPngBytes();
        if (data != null) {
          getSign = Image.memory(data!);
        }
      }
    }

    deletSignature() {
      signatureController.clear();
    }

    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Container(
            margin: const EdgeInsets.only(top: 25),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: 100,
                child: Image.asset("images/logo.jpeg"),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  "عقد ايجار",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormInfo(
                    infoType: "رقم الهاتف",
                    keybordType: TextInputType.phone,
                    controller: customerPhoneNumber,
                  ),
                  const SizedBox(width: 10),
                  TextFormInfo(
                      infoType: "الاسم",
                      keybordType: TextInputType.name,
                      controller: customerName),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HowLongCycle(),
                  const SizedBox(
                    width: 10,
                  ),
                  TextFormInfo(
                    infoType: "رقم الهويه",
                    keybordType: TextInputType.number,
                    controller: customerId,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HowManyCyclesAdult(),
                      HowManyCyclesKidz(),
                    ]),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(": السعر"),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(": السعر"),
                    )
                  ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 60,
                      width: 120,
                      child: Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Form(
                              child: Consumer<TotalPrice>(
                            builder: (context, val, child) => TextFormField(
                              onChanged: (value) {
                                try {
                                  val.adultPrice = int.parse(value);
                                } on FormatException {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2)))),
                            ),
                          )),
                        ),
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                      height: 60,
                      width: 120,
                      child: Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Form(
                              child: Consumer<TotalPrice>(
                            builder: (context, val, child) => TextFormField(
                              onChanged: ((value) {
                                try {
                                  val.kidzPrice = int.parse(value);
                                } on FormatException {
                                  return null;
                                }
                              }),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2)))),
                            ),
                          )),
                        ),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Consumer<TotalPrice>(
                  builder: (context, val, child) => ListTile(
                      title: MaterialButton(
                          child: Text(": المجموع"),
                          onPressed: () {
                            val.getTotal();
                          }),
                      leading: Container(
                        height: 60,
                        width: 120,
                        alignment: Alignment.center,
                        child: Container(
                            height: 60,
                            width: 120,
                            child: Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1)),
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("${val.totalPrice} ريال ")),
                            )),
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 364,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(width: 1),
                      horizontal: BorderSide(width: 1)),
                ),
                child: ListView(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: Text(
                        "الشروط والاحكام",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: conditions.conInAr.length,
                      itemBuilder: (context, i) => Container(
                        margin: EdgeInsets.all(20),
                        child: Text("${conditions.conInAr[i]}",
                            textDirection: TextDirection.rtl),
                      ),
                    ),
                    Divider(),
                    Container(
                        child: Text(
                      "Terms & Condition",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                    ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: conditions.conInEn.length,
                        itemBuilder: (context, i) => Container(
                              margin: EdgeInsets.all(20),
                              child: Text("${conditions.conInEn[i]}",
                                  textDirection: TextDirection.rtl),
                            )),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          child: Text("signature : ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 80,
                            width: 130,
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            child: SignHere(data: data),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 30,
                          child: Text(" : التوقيع",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              deletSignature();
                            },
                            child: Text("clear")),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await saveSignature();
                              lastVisit = DateTime.now();
                              howManyKidzCycles = context
                                  .read<HowManyCycleSelectedKidz>()
                                  .countKidzCycles;
                              howManyAdultCycles = context
                                  .read<HowManyCycleSelectedAdult>()
                                  .countAdultCycles;
                              rentDuration =
                                  context.read<RentDuration>().howLong!;
                              int response = await sqlDb.insertData('''
                                          INSERT INTO "clients" (id, name, phone , time, kidzCycles, adultCycles, duration )
                                           VALUES (${customerId!.text}, "${customerName!.text}", "${customerPhoneNumber!.text}", "$lastVisit", "$howManyKidzCycles", "$howManyAdultCycles", "$rentDuration" )
                                            ''');
                              await sqlDb.insertData('''
                                          INSERT INTO "currentClients" (id, name, phone , time, kidzCycles, adultCycles, duration )
                                           VALUES (${customerId!.text}, "${customerName!.text}", "${customerPhoneNumber!.text}", "$lastVisit", "$howManyKidzCycles", "$howManyAdultCycles", "$rentDuration")
                                            ''');
                              if (response > 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => ShowData(
                                          id: customerId!.text,
                                        ))));
                              }

                              deletSignature();
                              //      await removeDataBase();
                            },
                            child: Text("save "))
                      ],
                    )
                  ],
                ),
              )
            ]),
          )),
    );
  }
}
