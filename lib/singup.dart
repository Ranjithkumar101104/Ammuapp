import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_contacts.dart';

// void main() {
//   runApp(SignUpApp());
// }

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMMU SignUp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isloginmode = false;
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // Header with curved background and image
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Color(0xFF003366),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        !isloginmode ? 'images/book.png' : 'images/login.png',
                        height: 180,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100), // Compensate for image overlap
              // Welcome Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),

                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    !isloginmode
                        ? 'Welcome to AMMU!'
                        : 'Hi there! Welcome Back to Ammu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Mobile Number Field
              if (!isloginmode) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'mobile number is required';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'only digits are allowed';
                      } else if (value.length != 10) {
                        return 'mobile must be 10 digits';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
              ],

              // Email Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'enter a valid address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),

              // Password Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password is required";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 24),

              // Sign Up Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                       Timer(const Duration(seconds: 2), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyApp(),
                                    ),
                                  );
                                });
                      if (_formKey.currentState!.validate()) {
                        final mobile = mobileController.text;
                        final email = emailController.text;
                        final password =
                            passwordController
                                .text; // Fix: You were using emailController here again

                        if (!isloginmode) {
                          var url = Uri.parse(
                            "http://localhost:80/ammu/signup.php",
                             
                          );

                          var response = await http.post(
                            url,
                            body: {
                              'mobile': mobile,
                              'email': email,
                              'password': password,
                            },
                          );

                          if (response.statusCode == 200) {
                            final data = jsonDecode(response.body);

                            if (data['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Registered successfully!"),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              // void initState() {
                                // super.initState();
                                Timer(const Duration(seconds: 7), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyApp(),
                                    ),
                                  );
                                });
                              // }

                              mobileController.clear();
                              emailController.clear();
                              passwordController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(data['message']),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          } else {
                            print("HTTP error: ${response.statusCode}");
                          }
                        } else {

                         
                          emailController.clear();
                          passwordController.clear();

                          var url = Uri.parse(
                            "http://localhost:80/ammu/user.php",
                          );
                          var response = await http.post(
                            url,
                            body: {'email': email, 'password': password},
                          );
                          if (response.statusCode == 200) {
                            final data = jsonDecode(response.body);
                             
                            if (data['status'] == 'success') {
                             
                              
                            } else {
                             
                            }
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('please enter all feilds'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Text(
                      isloginmode ? 'Login In' : "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF003366),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Already have account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isloginmode
                        ? "Don't have an account?"
                        : 'Already have an account?',
                  ),
                  TextButton(
                    onPressed: () {
                      print('ok');

                      setState(() {
                        isloginmode = !isloginmode;
                      });
                    },
                    child: Text(isloginmode ? 'Sign Up' : 'Log In'),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or Sign Up with"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Button
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.asset('images/google.png', height: 20),
                    label: Text('Google'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),

                  // Facebook Button
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.asset('images/facebook.png', height: 20),
                    label: Text('Facebook'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
