import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:smartapp_fyp/screens/registration/loginpage.dart';
import 'package:smartapp_fyp/screens/request_for_product.dart';
import 'package:smartapp_fyp/screens/wish_list.dart';

import '../firestore database/fetech_data_firestore.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Select Category",
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assests/images/1.png',
            alignment: Alignment.topCenter,
          ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WishList()));
                //builder: (context) => UserInformation()));
              },
              icon: const Icon(EvaIcons.refresh),
              label: const Text('WishList')),

          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
                //builder: (context) => UserInformation()));
              },
              icon: const Icon(Icons.plus_one_outlined),
              label: const Text('Add Review')),
          // const CategoryButton(
          //   icon: Icon(Icons.plus_one_outlined),
          //   inputText: "Add Review",
          // ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => User()));
              },
              icon: const Icon(Icons.search),
              label: const Text('Search Product')),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestProduct()));
                //builder: (context) => UserInformation()));
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
    Key? key,
    required this.icon,
    required this.inputText,
  }) : super(key: key);
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
