
import 'package:esay_shoping/screens/auth_ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';



// import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:lottie/lottie.dart';


import '../../utils/app_constants.dart';


import 'package:lottie/lottie.dart';

import '../../utils/app_constants.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passworController = TextEditingController();
  bool _obscure = true;

  final  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: AppConstants.appMainColor,
          centerTitle: true,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
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
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Login",
                  style: TextStyle(
                    color: AppConstants.appSecondryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),

                Container(

                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10) ,
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
                      prefixIcon: Icon(Icons.email_outlined, )
                    ),
                  ),
                ),

                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter you Password";
                      }
                      if (value.length < 6) {
                        return 'Please enter stronge password .';
                      }
                      return null;
                    },
                    obscureText: _obscure,
                    controller: _passworController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Your Password",
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password, ),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          _obscure = !_obscure ;
                        });
                      }, icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),

                      ) ,

                    ),
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 12) ,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text("Forget Password" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w300),),
                  ),
                ) ,
                SizedBox(height: 10),


                Container(
                  margin: EdgeInsets.symmetric(vertical: 0 ,horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue ,
                            foregroundColor: Colors.white
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login with ${_emailController.text}"))) ;
                            }
                          },
                          child: Text("Login" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
                        ),
                      ),

                    ],
                  ),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Sign Up clicked!'),
                              backgroundColor: Theme.of(context).hintColor,
                            ),
                          );

                          Navigator.push(context, MaterialPageRoute(builder: (context) => Signup())) ;

                          // In a real app, you would navigate to a "Sign Up" screen here.
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(child: Scaffold(
      appBar: AppBar(
        title: Text("Login",),
        backgroundColor: AppConstants.appMainColor,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(color: AppConstants.appMainColor ,),
              child: Lottie.asset(
                "assets/images/Login.json",
                width: 500,
                height: 200,
              ),
            ),
            SizedBox(height: 20,),
            Text("Welcome to Login" , style: TextStyle(color: AppConstants.appSecondryColor, fontSize: 30 , fontWeight: FontWeight.bold))
          ],
        ),
      ),
    ));
  }


