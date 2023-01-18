import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartapp_fyp/Utils/utils.dart';
import 'package:smartapp_fyp/screens/registration/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Widgets/button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() async {
    try {
      setState(() => isLoading = true);
      UserCredential authRes = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      DocumentSnapshot doc = await _firebaseFirestore
          .collection("users")
          .doc(authRes.user!.uid)
          .get();
      final userInfo = {
        "user_id": authRes.user!.uid,
        "name": doc['name'],
        "email": doc['email'],
        "wishListIds": doc['wishListIds'],
      };
      await GetStorage().write("user_info", userInfo);
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = true);
      if (e.code == 'user-not-found') {
        Utils().toastmessage("User not Found");
      } else if (e.code == 'wrong-password') {
        Utils().toastmessage("Wrong password");
      }
    } finally {
      setState(() => isLoading = true);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        helperText: "sanoj@gmail.com",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
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
                      },
                    ),
                  ],
                )),
            const SizedBox(height: 25),
            isLoading ? const CircularProgressIndicator() : const SizedBox(),
            const SizedBox(height: 25),
            RoundButton(
                title: "Login",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Haven`t register yet?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SignUp())));
                    },
                    child: const Text("SignIn"))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
