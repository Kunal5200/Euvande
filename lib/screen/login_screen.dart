import 'dart:convert';

import 'package:euvande/main.dart';
import 'package:euvande/model/request/LoginRequestModel.dart';
import 'package:euvande/model/request/RegisterRequestModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/model/response/RegisterResponseModel.dart';
import 'package:euvande/screen/otp_screen.dart';
import 'package:euvande/screen/registration_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/KeyConstants.dart';
import 'package:euvande/utilities/MyLocalStorage.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

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
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  String submitButtonText = "Login";
  bool isEnabled = true;
  final TextEditingController emailResetController =
  TextEditingController(text: "");
  final TextEditingController emailController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  String sendOTPButtonText = "Next";
  GlobalKey<FormState> _formForgetPasswordKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    textFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffafcff),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 150.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png")),
                      ),
                    ),
                    Text(
                      "Enter your information to login account",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
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
                            borderSide: BorderSide(), // Apply corner radius
                          ),
                          prefixIcon: Icon(Icons.lock_rounded, size: 24),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
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
                      behavior: HitTestBehavior.translucent,
                      onTap: () => {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Form(
                                    key: _formForgetPasswordKey,
                                    child: SizedBox(
                                      height: 250,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text(
                                              "Forget Password",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Provide your account's email which you want to\nreset your password.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            TextFormField(
                                              controller: emailResetController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'This field is required';
                                                } else if (!RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(value)) {
                                                  return 'Invalid email entered';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Email',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                ),
                                                prefixIcon:
                                                    Icon(Icons.email, size: 24),
                                              ),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              style: raisedButtonStyle,
                                              child: Text(
                                                sendOTPButtonText,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                              onPressed: () {
                                                if (isEnabled &&
                                                    _formForgetPasswordKey
                                                        .currentState!
                                                        .validate()) {
                                                  callForgetOTPAPI(setState);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            });
                          },
                        )
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
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
                          callLoginAPI();
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationScreen()),
                        )
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )));
  }

  Future<void> _navigateOTPScreen(
      BuildContext context, RegisterResponseModel responseModel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Otp(
              response: responseModel,
              referenceId: responseModel.data!.referenceId.toInt(),
              verificationFor: FORGET_PASSWORD)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    if (result != null) {
      // Navigator.pop(context);
    }
  }

  void callLoginAPI() {
    setState(() {
      submitButtonText = "Logging...";
      isEnabled = false;
    });

    Future<LoginResponseModel> response = ApiService(context).login(
        LoginRequestModel(
            email: emailController.text, password: passwordController.text));
    response
        .then((value) => {
              SharedPrefManager.setLoginData(jsonEncode(value.toJson())),
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
                      builder: (context) => const MyHomePage(title: "")),
                  ModalRoute.withName("/RegistrationScreen"))
            })
        .catchError((onError) {
      setState(() {
        submitButtonText = "Login";
        isEnabled = true;
      });
    });
  }

  void callForgetOTPAPI(StateSetter setState) {
    setState(() {
      sendOTPButtonText = "Logging...";
      isEnabled = false;
    });

    Future<RegisterResponseModel> response = ApiService(context).forgotPassword(
        RegisterRequestModel(
            email: emailResetController.text, password: '', name: ''));
    response
        .then((value) => {
              Navigator.pop(context),
              _navigateOTPScreen(context, value),
              setState(() {
                sendOTPButtonText = "Next";
                isEnabled = true;
              })
            })
        .catchError((onError) {
      setState(() {
        sendOTPButtonText = "Next";
        isEnabled = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.message),
      ));
    });
  }
}
