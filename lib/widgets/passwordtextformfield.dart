import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class PasswordTextFormField extends StatelessWidget {
  final dynamic valid;
  final bool obscureText;
  final String name;
  final VoidCallback onTap;
  final dynamic onChanged;
  const PasswordTextFormField({super.key, required this.valid, required this.obscureText, required this.name, required this.onTap, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: valid,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: name,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            obscureText == true
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
