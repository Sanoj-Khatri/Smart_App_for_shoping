import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Feeback extends StatefulWidget {
  const Feeback({Key? key}) : super(key: key);

  @override
  State<Feeback> createState() => _FeebackState();
}

class _FeebackState extends State<Feeback> {
  final List<String> martList = [
    'Dawood SuperMart',
    'Marhaba',
    'ChaseUp',
    'Maxbachat',
  ];

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
  final List itemsStores = [];

  String? selectedValue;
  //final TextEditingController textEditingController = TextEditingController();

  String? selectedValueMart;
  String? selectedValueCompany;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField2(
                    value: selectedValueMart,
                    items: martList
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedValueMart = val as String;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: const InputDecoration(
                        labelText: "Select Mart",
                        prefixIcon: Icon(Icons.shopping_bag),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
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
                      setState(() {
                        selectedValueCompany = val as String;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: const InputDecoration(
                        labelText: "Select Company",
                        prefixIcon: Icon(Icons.branding_watermark),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField2(
                    value: selectedValue,
                    items: items
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val as String;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    decoration: const InputDecoration(
                        labelText: "Add Products",
                        prefixIcon: Icon(Icons.add),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.upload,
                    ),
                    label: const Text("Upload Feedback"),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
