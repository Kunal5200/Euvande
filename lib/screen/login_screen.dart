import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/login_screen.dart';
import 'package:euvande/screen/registration_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 25
          ),
          child:  Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/logos/logo.png")),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Or Phone number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    prefixIcon: Icon(Icons.email, size: 24),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),// Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.lock_rounded, size: 24),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => {

                  },
                 child :  Container(
                    alignment: Alignment.centerRight,
                    child: Text("Forget Password", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: raisedButtonStyleForm,
                  child: Text(
                    'Proceed'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {


                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   content: Text("Sending Message"),
                    // ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    )

                  },
                  child :  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account ?", style: TextStyle(color: Colors.black, fontSize: 16),),
                          SizedBox(width: 10,),
                          Text("Signup", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
