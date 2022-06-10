import 'package:bike_zoon_app/providers/rentDuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HowLongCycle extends StatefulWidget {
  const HowLongCycle({Key? key}) : super(key: key);

  @override
  State<HowLongCycle> createState() => _HowLongCycleState();
}

class _HowLongCycleState extends State<HowLongCycle> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        width: 100,
        height: 150,
        margin: EdgeInsets.only(bottom: 20, top: 20),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Consumer<RentDuration>(
          builder: (context, valu, child) => Column(children: [
            Text("عدد الساعات"),
            RadioListTile(
                title: Text("ساعه"),
                value: "ساعه",
                groupValue: valu.howLong,
                onChanged: (val) {
                  valu.changeDuration(val);
                }),
            RadioListTile(
                title: Text("نصف ساعه"),
                value: "نصف ساعه",
                groupValue: valu.howLong,
                onChanged: (val) {
                  valu.changeDuration(val);
                }),
          ]),
        ),
      ),
    );
  }
}
