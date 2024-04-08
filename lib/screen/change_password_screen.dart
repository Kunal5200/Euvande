import 'package:euvande/main.dart';
import 'package:euvande/model/request/ChangePasswordRequestModel.dart';
import 'package:euvande/model/response/ChangePasswordResponseModel.dart';
import 'package:euvande/model/response/RegisterResponseModel.dart';
import 'package:euvande/screen/otp_screen.dart';
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

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  final textFieldFocusNode1 = FocusNode();
  bool _obscured1 = true;

  final textFieldFocusNode2 = FocusNode();
  bool _obscured2 = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
      false;


    });
  }

  void _toggleObscured1() {
    setState(() {
      _obscured1 = !_obscured1;

      if (textFieldFocusNode1.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode1.canRequestFocus =
      false;
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;

      if (textFieldFocusNode2.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode2.canRequestFocus =
      false;
    });
  }

  String submitButtonText = "Update Password";
  String sendOTPButtonText = "Next";
  bool isEnabled = true;
  final TextEditingController oldPasswordController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController confirmPasswordController =
      TextEditingController(text: "");

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    textFieldFocusNode.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafcff),
        title: Text("Change Password"),
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
                    ),
                    TextFormField(
                        controller: oldPasswordController,
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
                            child: GestureDetector( behavior: HitTestBehavior.translucent,
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
                        obscureText: _obscured1,
                        focusNode: textFieldFocusNode1,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(), // Apply corner radius
                          ),
                          prefixIcon: Icon(Icons.lock_rounded, size: 24),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector( behavior: HitTestBehavior.translucent,
                              onTap: _toggleObscured1,
                              child: Icon(
                                _obscured1
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
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscured2,
                        focusNode: textFieldFocusNode2,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(), // Apply corner radius
                          ),
                          prefixIcon: Icon(Icons.lock_rounded, size: 24),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector( behavior: HitTestBehavior.translucent,
                              onTap: _toggleObscured2,
                              child: Icon(
                                _obscured2
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

  void callChangePasswordAPI() {

    setState(() {
      submitButtonText = "Processing...";
      isEnabled = false;
    });

    Future<ChangePasswordResponseModel> response = ApiService(context).changePassword(ChangePasswordRequestModel(oldPassword: oldPasswordController.text, newPassword: passwordController.text,));
    response
        .then((value) => {
              SharedPrefManager.updateAccessToken(value.data!.accessToken),
              setState(() {
                submitButtonText = "Update Password";
                isEnabled = true;
              }),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message),
              )),
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: "")),
                  ModalRoute.withName("/MyHomePage"))
            })
        .catchError((onError) {
      setState(() {
        submitButtonText = "Update Password";
        isEnabled = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.message),
      ));
    });
  }

}
