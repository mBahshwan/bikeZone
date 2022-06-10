import 'package:bike_zoon_app/widgets/agrementWidget.dart';
import 'package:flutter/material.dart';

class AgrementScreen extends StatefulWidget {
  const AgrementScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AgrementScreen> createState() => _AgrementScreenState();
}

TextEditingController customerName = TextEditingController();
TextEditingController customerId = TextEditingController();
TextEditingController customerPhoneNumber = TextEditingController();

class _AgrementScreenState extends State<AgrementScreen> {
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
