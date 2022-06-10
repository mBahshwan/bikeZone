import 'package:bike_zoon_app/database/sqlflite.dart';
import 'package:bike_zoon_app/providers/howManyCycleSelected.dart';
import 'package:bike_zoon_app/providers/rentDuration.dart';
import 'package:bike_zoon_app/screens/showdata.dart';
import 'package:bike_zoon_app/providers/totalPrice.dart';
import 'package:bike_zoon_app/widgets/agrementWidget.dart';
import 'package:bike_zoon_app/widgets/conditionsAndTerms.dart';
import 'package:bike_zoon_app/widgets/howLong.dart';
import 'package:bike_zoon_app/widgets/howManyCycleAdult.dart';
import 'package:bike_zoon_app/widgets/howManyCycleKidz.dart';
import 'package:bike_zoon_app/widgets/signatureHere.dart';
import 'package:bike_zoon_app/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReNewAgrement extends StatefulWidget {
  final String? customerName;
  final customerId;
  final customerPhoneNumber;
  ReNewAgrement({
    Key? key,
    this.customerName,
    this.customerId,
    this.customerPhoneNumber,
  }) : super(key: key);

  @override
  State<ReNewAgrement> createState() => _ReNewAgrementState();
}

TextEditingController customerName = TextEditingController();
TextEditingController customerId = TextEditingController();
TextEditingController customerPhoneNumber = TextEditingController();

class _ReNewAgrementState extends State<ReNewAgrement> {
  @override
  void initState() {
    customerName.text = widget.customerName!;
    customerId.text = widget.customerId;
    customerPhoneNumber.text = widget.customerPhoneNumber;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AgrementWidget(
          customerName: customerName,
          customerId: customerId,
          customerPhoneNumber: customerPhoneNumber,
        ));
  }
}
