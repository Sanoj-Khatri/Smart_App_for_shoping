// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:smartapp_fyp/screens/registration/Widgets/button.dart';
import 'package:smartapp_fyp/screens/registration/registration.dart';

import 'Widgets/heading.dart';
import 'Widgets/inputfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeadingText(
                text: "Login",
              ),
              const SizedBox(
                height: 20,
              ),
              InputPhoneNumber(
                hintText: "Enter Phone Number",
                prefixIcon: const Icon(Icons.phone),
                fillColor: Colors.grey,
              ),
              const SizedBox(height: 20),
              InputPasswordField(
                hintText: "Enter Password",
                icon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              RoundButton(
                title: "Login",
                onTap: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Haven`t register yet?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignUp())));
                      },
                      child: const Text("SignIn"))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
