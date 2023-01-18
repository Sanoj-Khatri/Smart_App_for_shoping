import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestProduct extends StatefulWidget {
  const RequestProduct({Key? key}) : super(key: key);

  @override
  State<RequestProduct> createState() => _RequestProductState();
}

class _RequestProductState extends State<RequestProduct> {
  TextEditingController productName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Request for Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: productName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Product Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: companyName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Company Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Map<String, String> dataToSave = {
                    'mart': "",
                    'product_name': productName.text.toString(),
                    'brand': companyName.text.toString(),
                  };
                  FirebaseFirestore.instance
                      .collection('Product_Request')
                      .add(dataToSave);
                },
                //Quick Alert to be set when Successfully data request sent
                icon: const Icon(Icons.send),
                label: const Text("send Request"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
