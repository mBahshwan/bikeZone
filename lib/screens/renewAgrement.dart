import 'package:bike_zoon_app/widgets/agrementWidget.dart';
import 'package:flutter/material.dart';

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
