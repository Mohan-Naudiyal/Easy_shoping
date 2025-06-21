import 'package:esay_shoping/screens/user_panel/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/email-sign-up-controller.dart';
import '../../models/user-model.dart';
import '../../utils/app_constants.dart';
import 'Login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _obscure = true;

  final _formKey = GlobalKey<FormState>();

  bool _Loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: AppConstants.appMainColor,
        centerTitle: true,
      ),
      body: Stack(
        children:[ SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Welcome to Sign Up",
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
                          return "Enter Your City Number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      controller: _userController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Your Name",
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return "Enter Your Contact Number";
                        }
                        if (value.length < 10 || value.length > 10) {
                          return "Enter valid Number ";
                        }
                        null;
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Your Mobile Number",
                        labelText: "Number",
                        prefixIcon: Icon(Icons.phone_android_outlined),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your Contact Number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      controller: _cityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Your City Name",
                        labelText: "City",
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
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
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscure,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Your Password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
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

                            onPressed: _Loading ?null :() async {

                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _Loading = true;
                                });
                                try {
                                  UserModel? user = await RegistrationService()
                                      .registerUser(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        username: _userController.text,
                                        phone: _phoneController.text,
                                        userImg: "",
                                        country: "",
                                        userAddress: "",
                                        street: "",
                                        isAdmin: false,
                                        isActive: true,
                                        createdOn: DateTime.now(),
                                        city: _cityController.text ,
                                      );
                                  setState(() {
                                    _Loading = false;
                                  });

                                  if (user != null) {
                                    Get.offAll(
                                      () => WelcomeScreen(),
                                    ); // Navigate to home
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Welcome ${user.username}!',
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Hlo.... ${e.toString()}')),
                                  );
                                }
                                Get.offAll(() => Login()) ;
                              }
                            },
                            child: Text(
                              "Sign Up",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "You have Already an account?",
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Sign Up clicked!'),
                              backgroundColor: Theme.of(context).hintColor,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );

                          // In a real app, you would navigate to a "Sign Up" screen here.
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      if(_Loading)
        Center(
          child: CircularProgressIndicator(),
        )

        ]
      ),
    );
  }
}
