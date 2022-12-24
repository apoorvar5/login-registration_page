import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../widgets/changeaccount.dart';
import '../widgets/mytextformfield.dart';
import '../widgets/passwordtextformfield.dart';
import 'package:global_snack_bar/global_snack_bar.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regex = new RegExp(pattern);
bool obscureText = true;
String email = "";
String password = "";

class _SignUpState extends State<SignUp> {
  void validation() async {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(result.user!.uid);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login With Your Email And Password!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.cyan,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => Login()),
        );
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
      print("NO");
    }
  }

  Widget _buildAllTextFormField() {
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
            name: "Username",
            valid: (value) {
              if (value == "") {
                return "Please Enter Username";
              } else if (value!.length < 6) {
                return "Username is too short";
              }
            },
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
          MyTextFormField(
            name: "Phonenumber",
            valid: (value) {
              if (value == "") {
                return "Please Enter PhoneNumber";
              } else if (value!.length < 10) {
                return "Phone number must be 10 digits";
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
            obscureText: obscureText,
            name: "Password",
            onChanged: (value) {
              setState(() {
                password = value;
                print(password);
              });
            },
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      height: 450,
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          MyButton(
            name: "SignUp",
            onPressed: () {
              validation();
            },
          ),
          SizedBox(
            height: 12,
          ),
          ChangeScreen(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => Login(),
              ));
            },
            whichAccount: "Already Have An Account?",
            name: "Login!",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Super Mart",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBottomPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
