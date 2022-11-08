import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:smartapp_fyp/screens/feeback.dart';
import 'package:smartapp_fyp/screens/registration/loginpage.dart';
import 'package:smartapp_fyp/screens/request_for_product.dart';
import 'package:smartapp_fyp/screens/search_product.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required String title}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Category",
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CategoryButton(
            icon: Icon(Icons.phone),
            inputText: "Add Product",
          ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchProduct()));
              },
              icon: const Icon(Icons.search),
              label: const Text('Search Product')),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestProduct()));
              },
              icon: const Icon(EvaIcons.folderAdd),
              label: const Text('Request to add Product')),
        ],
      )),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final Widget icon;
  final String inputText;

  const CategoryButton({
    required this.icon,
    required this.inputText,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(maximumSize: const Size.fromHeight(50)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        },
        icon: icon,
        label: Text(inputText));
  }
}
