import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/model/request/LoginRequestModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/screen/dashboard_screen.dart';
import 'package:euvande/screen/login_screen.dart';
import 'package:euvande/screen/registration_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  String submitButtonText = "Login";
  bool isEnabled = true;
  final TextEditingController emailController = TextEditingController(text: "asek304@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 25
          ),
          child:  SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60,),
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
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)){
                      return 'Invalid email entered';
                    }
                    return null;
                  },
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                  TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
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
                      submitButtonText,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      if (isEnabled && _formKey.currentState!.validate()) {
                        setState(() {
                          submitButtonText = "Logging...";
                          isEnabled = false;
                        });

                        Future<LoginResponseModel> response =
                        ApiService().login(LoginRequestModel(email: emailController.text, password: passwordController.text));

                        response.then((value) => {

                          setState(() {
                            submitButtonText = "Login";
                            isEnabled = true;
                          }),

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value.message),
                          )),
                        Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const DashboardScreen()),
                        ModalRoute.withName("/RegistrationScreen")
                        )
                        }).catchError((onError){

                          setState(() {
                            submitButtonText = "Login";
                            isEnabled = true;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(onError.message),
                          ));
                        });
                      }

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
          )
        ));
  }
}
