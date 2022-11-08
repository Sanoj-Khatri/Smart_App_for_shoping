// import 'package:flutter/material.dart';
// import 'package:smartapp_fyp/screens/registration/Widgets/button.dart';

// import 'Widgets/inputfield.dart';

// class Registration extends StatefulWidget {
//   const Registration({Key? key}) : super(key: key);

//   @override
//   State<Registration> createState() => _RegistrationState();
// }

// class _RegistrationState extends State<Registration> {
//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Registration",
//                 style: TextStyle(
//                     fontSize: 50,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.purple,
//                     fontStyle: FontStyle.italic),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               InputPhoneNumber(
//                 hintText: "Enter Phone Number",
//                 prefixIcon: const Icon(Icons.phone),
//                 fillColor: Colors.grey,
//               ),
//               const SizedBox(height: 20),
//               InputPasswordField(
//                 hintText: "Enter Password",
//                 icon: const Icon(Icons.password),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               InputPasswordField(
//                 hintText: "Re-write Password",
//                 icon: const Icon(Icons.password),
//               ),
//               const SizedBox(height: 30),
//               RoundButton(
//                   title: "Sign Up",
//                   onTap: () {
//                     RoundButton(
//                       title: "Login",
//                       onTap: () {
//                         if (formKey.currentState!.validate()) {}
//                       },
//                     );
//                   }),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

// ignore_for_file: unnecessary_const

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartapp_fyp/screens/registration/Widgets/button.dart';
import 'package:smartapp_fyp/screens/registration/registration.dart';
import 'Widgets/heading.dart';
import 'Widgets/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                text: "Sign Up",
              ),
              const SizedBox(
                height: 20,
              ),
              // InputPhoneNumber(
              //   hintText: "Enter Phone Number",
              //   prefixIcon: const Icon(Icons.phone),
              //   fillColor: Colors.grey,
              // ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    fillColor: Colors.green,
                    hintText: "Enter Email",
                    //icon: Icon(Icons.phone),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Phone Number";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              // InputPasswordField(
              //   hintText: "Enter Password",
              //   icon: const Icon(Icons.lock),
              // ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.green,
                    hintText: "Password",
                    //icon: Icon(Icons.phone),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Password";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              RoundButton(
                title: "Sign Up",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _auth.createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
