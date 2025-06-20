
import 'package:esay_shoping/controllers/email_Login.dart';
import 'package:esay_shoping/controllers/get-user-data-Controller.dart';
import 'package:esay_shoping/models/user-model.dart';
import 'package:esay_shoping/screens/auth_ui/forget-password.dart';
import 'package:esay_shoping/screens/auth_ui/signup.dart';
import 'package:esay_shoping/screens/auth_ui/welcome_screen.dart';
import 'package:esay_shoping/screens/user_panel/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../utils/app_constants.dart';
import '../user_panel/admin_screen.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GetUserDataController getUserDataController = Get.put(GetUserDataController()) ;
  final LoginService _loginService = LoginService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  bool _Loading = false;

  final  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible){
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
            child: SingleChildScrollView(
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
                  ):SizedBox(height: 20,) ,
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
                      controller: _passwordController,
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
              
                  InkWell(
                    onTap: () {
                      Get.to(() => ForgetPasssword()) ;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 12) ,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text("Forget Password" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w300),),
                      ),
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
                            onPressed: () async {
                              setState(() => _Loading = true);
              
                              try {
                                final email = _emailController.text.trim();
                                final password = _passwordController.text.trim();
              
                                // Basic validation
                                if (email.isEmpty || password.isEmpty) {
                                  Get.snackbar("Error", "Please enter email and password");
                                  return;
                                }
              
                                // 1. Login user
                                final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
              
                                // 2. Get user data
                                final userData = await getUserDataController.getUserData(userCredential.user!.uid);
              
                                // 3. Check verification status
                                await userCredential.user?.reload();
                                if (userCredential.user?.emailVerified ?? false) {
                                  // Navigate based on admin status
                                  if (userData['isAdmin'] == true) {  // Compare with boolean, not string
                                    Get.offAll(() => AdminScreen());
                                  } else {
                                    Get.offAll(() => WelcomeScreen());
                                  }
                                } else {
                                  await userCredential.user?.sendEmailVerification();
                                  await FirebaseAuth.instance.signOut();
                                  Get.snackbar(
                                    "Verify Email",
                                    "Please check your email for verification link",
                                    duration: Duration(seconds: 5),
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                String message = e.code == 'user-not-found' ? 'Email not registered'
                                    : e.code == 'wrong-password' ? 'Wrong password'
                                    : 'Login failed';
                                Get.snackbar("Error", message);
                              } catch (e) {
                                Get.snackbar("Error", e.toString());
                              } finally {
                                if (mounted) setState(() => _Loading = false);
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
        )],
      ),
    );
    }) ;
  }
}


