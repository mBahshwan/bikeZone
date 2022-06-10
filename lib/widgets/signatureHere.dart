import 'dart:io';
import 'dart:typed_data';
import 'package:bike_zoon_app/database/sqlflite.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignHere extends StatefulWidget {
  final Uint8List? data;
  const SignHere({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<SignHere> createState() => _SignHereState();
}

SqlDb sqlDb = SqlDb();
File? file;
SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.grey,
    penColor: Colors.black);

class _SignHereState extends State<SignHere> {
  @override
  Widget build(BuildContext context) {
    return Signature(
      controller: signatureController as SignatureController,
      backgroundColor: Colors.white,
      height: 80,
      width: 130,
    );
  }
}
