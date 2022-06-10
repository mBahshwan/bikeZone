import 'package:bike_zoon_app/screens/renewAgrement.dart';
import 'package:bike_zoon_app/widgets/CID.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<int> {
  final List<Map>? customerTitle;
  DataSearch(
    this.customerTitle,
  );

  String? id;
  String? name;
  String? phoneNumber;
  List<Map>? filterList;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReNewAgrement(
                  customerId: id,
                  customerName: name,
                  customerPhoneNumber: phoneNumber),
            ));
          },
          child: Icon(Icons.add)),
      body: CustomerInformation(
        customerTitle: customerTitle,
        id: id,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    filterList = customerTitle!
        .where((element) => element.containsValue(int.tryParse(query)))
        .toList();
    return ListView.builder(
      itemCount: query.isEmpty ? customerTitle!.length : filterList!.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            id = query.isEmpty
                ? "${customerTitle![i]['id']}"
                : "${filterList![i]['id']}";
            name = query.isEmpty
                ? "${customerTitle![i]['name']}"
                : "${filterList![i]['name']}";
            phoneNumber = query.isEmpty
                ? "${customerTitle![i]['phone']}"
                : "${filterList![i]['phone']}";

            query = query.isEmpty
                ? "${customerTitle![i]['name']}"
                : "${filterList![i]['name']}";

            showResults(context);
          },
          child: ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: query.isEmpty
                  ? Text("${customerTitle![i]['name']}")
                  : Text("${filterList![i]['name']}")),
        );
      },
    );
  }
}
