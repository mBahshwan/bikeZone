import 'package:bike_zoon_app/providers/howManyCycleSelected.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HowManyCyclesKidz extends StatefulWidget {
  HowManyCyclesKidz({Key? key}) : super(key: key);

  @override
  State<HowManyCyclesKidz> createState() => _HowManyCyclesKidzState();
}

class _HowManyCyclesKidzState extends State<HowManyCyclesKidz> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Text(
            " عدد الدراجات (اطفال)",
            style: TextStyle(fontSize: 15),
          ),
          Consumer<HowManyCycleSelectedKidz>(
            builder: (context, provider, child) => DropdownButton(
              items: [0, 1, 2, 3, 4, 5, 6]
                  .map((e) => DropdownMenuItem(
                        child: Text("$e"),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                provider.selectedKidzCycles(val);
              },
              value: provider.countKidzCycles,
            ),
          ),
        ],
      ),
    );
  }
}
