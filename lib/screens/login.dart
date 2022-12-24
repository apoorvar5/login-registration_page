import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/screens/signup.dart';
import 'package:ecommerce_app/widgets/mytextformfield.dart';
import 'package:ecommerce_app/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/mybutton.dart';

import '../widgets/changeaccount.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regex = new RegExp(pattern);
String password = "";
String email = "";
bool obscureText = true;


class _LoginState extends State<Login> {
  void validation() async {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print(result.user!.uid);
        print("Authentication Successful!");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> HomePage()),);
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.cyan,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      print('NO');
    }
  }
  Widget _buildAllPart({required BuildContext context}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Super Mart',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          MyTextFormField(
            name: "Email",
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            valid: (value) {
              if (value == "") {
                return "Please Enter Email!";
              } else if (!regex.hasMatch(value!)) {
                return "Email Is Invalid!";
              }
            },
          ),
          PasswordTextFormField(
            valid: (value) {
              if (value == "") {
                return "Please Enter Password";
              } else if (value!.length < 8) {
                return "Password Is Too Short";
              }
            },
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: obscureText,
            name: "Password",
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
              FocusScope.of(context).unfocus();
            },
          ),
          MyButton(
            name: "Login",
            onPressed: () {
              validation();
            },
          ),
          ChangeScreen(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => SignUp(),
              ));
            },
            whichAccount: "Don't Have An Account?",
            name: "SignUp!",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 425,
                  width: double.infinity,
                  child: _buildAllPart(context: context)),
            ],
          ),
        ),
      ),
    );
  }
}
