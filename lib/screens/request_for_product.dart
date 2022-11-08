// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:fitted_text_field_container/fitted_text_field_container.dart';

class RequestProduct extends StatefulWidget {
  const RequestProduct({Key? key}) : super(key: key);

  @override
  State<RequestProduct> createState() => _RequestProductState();
}

class _RequestProductState extends State<RequestProduct> {
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
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Company Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Product Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
