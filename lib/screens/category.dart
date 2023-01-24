import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartapp_fyp/Utils/utils.dart';
import 'package:smartapp_fyp/screens/registration/loginpage.dart';
import 'package:smartapp_fyp/screens/request_for_product.dart';
import 'package:smartapp_fyp/screens/wish_list.dart';

import 'product_screen.dart';

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
        actions: [
          IconButton(
              onPressed: () async {
                if (GetStorage().read("user_info") != null) {
                  await FirebaseAuth.instance.signOut();
                  await GetStorage().erase();
                  Utils().toastmessage("Logout Successfully");
                }
              },
              icon: Icon(Icons.logout_outlined))
        ],
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
                if (GetStorage().read("user_info") != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductsScreen()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                }
              },
              icon: const Icon(Icons.plus_one_outlined),
              label: const Text('Add Review')),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsScreen()));
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
