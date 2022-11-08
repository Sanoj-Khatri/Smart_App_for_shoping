import 'package:flutter/material.dart';

class InputPasswordField extends StatelessWidget {
  final passwordController = TextEditingController();

  final String hintText;
  final Icon icon;
  InputPasswordField({
    required this.hintText,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: icon,
          fillColor: Colors.grey,
          hintText: hintText,
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
    );
  }
}

class InputPhoneNumber extends StatelessWidget {
  final emailController = TextEditingController();

  final String hintText;
  final Icon prefixIcon;
  final Color fillColor;

  InputPhoneNumber({
    required this.hintText,
    required this.prefixIcon,
    required this.fillColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          hintText: hintText,
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
    );
  }
}
