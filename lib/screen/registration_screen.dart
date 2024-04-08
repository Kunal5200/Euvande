import 'package:dio/dio.dart';
import 'package:euvande/main.dart';
import 'package:euvande/model/request/RegisterRequestModel.dart';
import 'package:euvande/model/response/RegisterResponseModel.dart';
import 'package:euvande/screen/login_screen.dart';
import 'package:euvande/screen/otp_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/KeyConstants.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();
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

  String submitButtonText = 'Proceed'.toUpperCase();
  bool isEnabled = true;
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController = TextEditingController(text: "");
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> _navigateOTPScreen(
      BuildContext context, RegisterResponseModel responseModel) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Otp(
                response: responseModel,
                referenceId: responseModel.data!.referenceId.toInt(),
              verificationFor : REGISTER
              )),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    if (result != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "")),
          ModalRoute.withName("/RegistrationScreen")
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('${result.result}')));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
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
              SizedBox(height: 50,),
              Container(
                width: 150.0,
                height: 50.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logos/logo.png")),
                ),
              ),
              Text("Enter your information to create an account", style: TextStyle(color: Colors.black54, fontSize: 14,),),
              SizedBox(height: 30,),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  prefixIcon: Icon(Icons.person, size: 24),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  prefixIcon: Icon(Icons.email, size: 24),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)){
                    return 'Invalid email entered';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwordController,
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
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              // IntlPhoneField(
              //   controller: phoneNumberController,
              //   validator: (value) {
              //     if (value == null || value.number.isEmpty) {
              //       return 'This field is required';
              //     }
              //     return null;
              //   },
              //   focusNode: focusNode,
              //   decoration: InputDecoration(
              //     labelText: 'Phone Number',
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(),
              //     ),
              //   ),
              //   languageCode: "en",
              //   onChanged: (phone) {
              //     print(phone.completeNumber);
              //   },
              //   onCountryChanged: (country) {
              //     print('Country changed to: ' + country.name);
              //   },
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              ElevatedButton(
                style: raisedButtonStyleForm,
                child: Text(
                  submitButtonText,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  // showModalBottomSheet<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return Container(
                  //       height: 400,
                  //       color: Colors.amber,
                  //       child: Center(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             const Text('Modal BottomSheet'),
                  //             ElevatedButton(
                  //               child: const Text('Close BottomSheet'),
                  //               onPressed: () => Navigator.pop(context),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                  if (isEnabled && _formKey.currentState!.validate()) {
                    setState(() {
                      submitButtonText = "Proceeding...";
                      isEnabled = false;
                    });

                    registerAPI();

                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector( behavior: HitTestBehavior.translucent,
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  )
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Login",
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
      ),
    ));
  }

  void registerAPI() {

    Future<RegisterResponseModel> response = ApiService(context)
        .register(RegisterRequestModel(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text));
    response
        .then((value) => {

      _navigateOTPScreen(context, value),

      setState(() {
        submitButtonText = 'Proceed'.toUpperCase();
        isEnabled = true;
      }),

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
        content: Text(value.message),
      )),
    })
        .catchError((onError) {

      setState(() {
        submitButtonText = 'Proceed'.toUpperCase();
        isEnabled = true;
      });

      Response response = onError.response as Response;
      if (response.statusCode == 408) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("An account with this Email already exists."),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(onError.message),
        ));
      }
    });
  }
}
