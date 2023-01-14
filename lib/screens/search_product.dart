import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../firestore database/fetech_data_firestore.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
//  SlidableController _slidableController;
  final List<String> companyList = [
    'Shan',
    'National',
    'Menu',
    'Habib',
    'Mehran',
    'Ajwa'
  ];
  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];
  List<String> emptylistCompany = [];
  List<String> emptylistItem = [];

  String? selectedValueCompany;

  String? selectedValueItem;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              DropdownButtonFormField2(
                value: selectedValueCompany,
                items: companyList
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(
                    () {
                      selectedValueCompany = val! as String?;
                      emptylistCompany.add(selectedValueCompany!);
                    },
                  );
                },
                icon: const Icon(Icons.arrow_drop_down),
                decoration: const InputDecoration(
                  labelText: "Select Mart",
                  prefixIcon: Icon(Icons.shopping_bag),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField2(
                value: selectedValueItem,
                items: items
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(
                    () {
                      selectedValueItem = val! as String?;
                      emptylistItem.add(selectedValueItem!);
                    },
                  );
                },
                icon: const Icon(Icons.arrow_drop_down),
                decoration: const InputDecoration(
                  labelText: "Select Company",
                  prefixIcon: Icon(Icons.branding_watermark),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                thickness: 2,
                color: Color.fromARGB(124, 155, 39, 176),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: emptylistItem.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 84, 84, 227),
                            Color.fromARGB(255, 220, 220, 220)
                          ],
                          stops: [0, 2],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: ListTile(
                        title: Text(
                          emptylistCompany[index].toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        subtitle: Text(
                          emptylistItem[index].toString(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
