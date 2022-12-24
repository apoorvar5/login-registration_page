import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:flutter/material.dart';
class MyTextFormField extends StatelessWidget {
  final dynamic valid;
  final dynamic onChanged;
  final String name;
  MyTextFormField({this.onChanged, required this.name, required this.valid});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: valid,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: name,
      ),
    );
  }
}
