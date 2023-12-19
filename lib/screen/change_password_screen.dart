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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _formForgetPasswordKey = GlobalKey();

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

  String submitButtonText = "Update Password";
  String sendOTPButtonText = "Next";
  bool isEnabled = true;
  final TextEditingController oldPasswordController =
      TextEditingController(text: "asek304@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");

  @override
  void dispose() {
    oldPasswordController.dispose();
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
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png")),
                      ),
                    ),TextFormField(
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
                          labelText: "Old Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(), // Apply corner radius
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
                          labelText: "New Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(), // Apply corner radius
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
                    Text(
                        "✓ The password must be at least 8 characters long.\n"
                        "✓ It must include at least one alphabet character.\n"
                        "✓ It must include at least one numeric digit (0-9).\n"
                        "✓ It must include at least one special character from the set: !@#\$%^&*\n"
                        "✓ Spaces are not allowed within the password.\n",
                      style: TextStyle(fontSize: 10),
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
                          callChangePasswordAPI();
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
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
              referenceId: responseModel.data.referenceId,
              verificationFor: FORGET_PASSWORD)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    if (result != null) {
      // Navigator.pop(context);
    }
  }

  void callChangePasswordAPI() {
    setState(() {
      submitButtonText = "Logging...";
      isEnabled = false;
    });

    Future<LoginResponseModel> response = ApiService().login(LoginRequestModel(
        email: oldPasswordController.text, password: passwordController.text));
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.message),
      ));
    });
  }

}
