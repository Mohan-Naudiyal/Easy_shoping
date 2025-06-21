import 'package:esay_shoping/controllers/email_Login.dart';
import 'package:esay_shoping/screens/auth_ui/Login.dart';
import 'package:esay_shoping/screens/auth_ui/signup.dart';
import 'package:esay_shoping/screens/user_panel/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/forget_password.dart';
import '../../utils/app_constants.dart';

class ForgetPasssword extends StatefulWidget {
  const ForgetPasssword({super.key});

  @override
  State<ForgetPasssword> createState() => _ForgetPassswordState();
}

class _ForgetPassswordState extends State<ForgetPasssword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  bool _Loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Forget Password"),
          backgroundColor: AppConstants.appMainColor,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            if (_Loading) Center(child: CircularProgressIndicator()),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    !isKeyboardVisible ?Container(
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        color: AppConstants.appMainColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Lottie.asset(
                        "assets/images/Login.json",
                        width: 500,
                        height: 200,
                      ),
                    ):
                    SizedBox(height: 20),
                    Text(
                      "Forget Password",
                      style: TextStyle(
                        color: AppConstants.appSecondryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter you Email";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },

                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Your Email",
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                final email = _emailController.text.trim();
                                setState(() {
                                  _Loading = true;
                                });
                                if (email.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Please enter your email",
                                  );
                                } else {
                                  Forget().forgetPassword(email);
                                  setState(() {
                                    _Loading = false;
                                  });
                                  Get.to(() => Login());
                                }
                              },

                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  });
  }
}
