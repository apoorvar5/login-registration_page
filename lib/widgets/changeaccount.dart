import 'package:flutter/material.dart';
class ChangeScreen extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final String whichAccount;
  ChangeScreen({required this.name, required this.onTap, required this.whichAccount});
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(whichAccount),
        SizedBox(
          width: 2,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            name,
            style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ],
    );
  }
}
