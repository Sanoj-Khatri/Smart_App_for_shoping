import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartapp_fyp/Utils/utils.dart';
import 'package:smartapp_fyp/screens/product_screen.dart';
import 'package:smartapp_fyp/firestore%20database/user_provider.dart';
import 'package:smartapp_fyp/models/user_model.dart';
import 'package:smartapp_fyp/screens/search_product.dart';
import '../../Widgets/button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void registerUser(
      {required String email,
      required String name,
      required String pass}) async {
    try {
      setState(() => loading = true);
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      //Create a new User in firestore
      UserModel user = UserModel(
        userId: authResult.user?.uid,
        name: name,
        email: email,
      );
      //Create new user
      await UserProvider().createNewUser(user);
      if (await UserProvider().createNewUser(user)) {
        final userInfo = {
          "user_id": user.userId,
          "name": user.name,
          "email": user.email,
          "wishListIds": user.wishListIds,
        };
        await GetStorage().write("user_info", userInfo);
      }
      setState(() => loading = false);
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProductsScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() => loading = false);
      if (e.code == 'weak-password') {
        Utils().toastmessage('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Utils().toastmessage("The account already exists");
      }
    } catch (e) {
      Utils().toastmessage("Something went wrong $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
            loading ? const CircularProgressIndicator() : const SizedBox(),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
                title: "SignUp",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    registerUser(
                        email: emailController.text,
                        name: nameController.text,
                        pass: passwordController.text);
                  }
                }),
          ],
        ),
      ),
    ));
  }
}
