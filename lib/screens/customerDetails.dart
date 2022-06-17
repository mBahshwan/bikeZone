import 'package:bike_zoon_app/components/appLocal.dart';
import 'package:bike_zoon_app/database/sqlflite.dart';
import 'package:bike_zoon_app/screens/renewAgrement.dart';
import 'package:bike_zoon_app/widgets/CID.dart';
import 'package:flutter/material.dart';

class CustomerDetails extends StatefulWidget {
  final List<Map>? customerTitle;
  final String? id;
  final String? cusomerName;
  final String? customerPhoneNumber;

  CustomerDetails({
    Key? key,
    this.customerTitle,
    this.id,
    this.cusomerName,
    this.customerPhoneNumber,
  }) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    @override
    SqlDb sqlDb = SqlDb();

    @override
    void initState() {
      print("===========================================================");
      super.initState();
    }

    showCustomerHowManyTimesCame() async {
      int howManyTimeCustomerCame = await sqlDb.getCount("${widget.id}");
      if (howManyTimeCustomerCame >= 6) {
        int del = await sqlDb
            .deleteData("DELETE FROM clients WHERE id = ${widget.id}");
        if (del > 0) {
          setState(() {
            widget.customerTitle!
                .removeWhere((element) => element['id'] == widget.id);
          });
        }
      } else {
        return howManyTimeCustomerCame;
      }
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReNewAgrement(
                    customerId: widget.id,
                    customerName: "${widget.cusomerName}",
                    customerPhoneNumber: "${widget.customerPhoneNumber}"),
              ));
            },
            child: Icon(Icons.add)),
        appBar: AppBar(
            title: Text(
              "${getLang(context, "customer details")}",
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("showData");
                },
                icon: Icon(Icons.arrow_back))),
        body: CustomerInformation(
          customerTitle: widget.customerTitle,
          id: widget.id,
        ));
  }
}
