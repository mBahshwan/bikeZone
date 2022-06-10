import 'package:flutter/material.dart';

class TextFormInfo extends StatelessWidget {
  final String? infoType;
  final TextInputType? keybordType;
  final TextEditingController? controller;

  TextFormInfo({
    Key? key,
    this.infoType,
    this.keybordType,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = new GlobalKey<FormState>();
    return Expanded(
      flex: 2,
      child: Container(
        width: 100,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Form(
            key: formState,
            child: TextFormField(
              controller: controller,
              keyboardType: keybordType,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: infoType,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
            )),
      ),
    );
  }
}
