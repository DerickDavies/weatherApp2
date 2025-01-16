import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/data/repositories/auth_repository.dart';
import 'package:weather_app/ui/Weather/view_model/login_in_notifier.dart';
import 'package:weather_app/ui/Weather/view_model/sign_up_notifier.dart';
import 'package:weather_app/ui/Weather/widget/tabs_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInstance = FirebaseAuth.instance;

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool accountExists = false;

  @override
  Widget build(BuildContext context) {
    final _signUp = ref.read(signUpNotifierProvider.notifier);
    final _login = ref.read(loginInNotifierProvider.notifier);
    final authenticationProvider = ref.read(authRepositoryProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(137, 115, 115, 116),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/cloud.png",
                  width: 250,
                  height: 250,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  height: 480,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(214, 226, 226, 226),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                accountExists ? "Sign Up" : "Login",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text("Email"),
                              icon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }

                              if (!value.contains("@") ||
                                  !value.contains(".com")) {
                                return 'Please enter a valid email address';
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text("Password"),
                              icon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field cannot be empty";
                              }

                              if (value.length < 8) {
                                return "Passwords must be atleast 8 characters long";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            icon: Icon(
                              accountExists ? Icons.person_add : Icons.login,
                              color: Colors.white,
                            ),
                            label: Text(accountExists ? "Sign Up" : "Login"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(43, 250, 250, 250),
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                if (accountExists) {
                                  try {
                                    await _signUp.createNewUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );

                                    await Future.delayed(Duration(seconds: 2));

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TabsScreen(),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    String message = '';
                                    if (e.code == 'weak-password') {
                                      message =
                                          'The password provided is too weak';
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      message =
                                          'An account already exists with that email';
                                    }
                                    Fluttertoast.showToast(
                                      msg: message,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.SNACKBAR,
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      fontSize: 14,
                                    );
                                  }
                                } else {
                                  try {
                                    await _login.loginUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TabsScreen(),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    String message = '';
                                    if (e.code == 'invalid-email') {
                                      message = 'No user found for that email';
                                    } else if (e.code == 'invalid-credential') {
                                      message =
                                          'Wrong password provided for that user';
                                    }

                                    Fluttertoast.showToast(
                                      msg: message,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.SNACKBAR,
                                      backgroundColor: Colors.black54,
                                      textColor: Colors.white,
                                      fontSize: 14,
                                    );
                                  }
                                }
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                accountExists
                                    ? "Already have an account"
                                    : "Don't have an account?",
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    accountExists = !accountExists;
                                  });
                                },
                                child: Text(accountExists
                                    ? "Sign In"
                                    : "Register Here"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Or",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await authenticationProvider.signInWithGoogle();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TabsScreen(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                Fluttertoast.showToast(
                                  msg: e.code,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.SNACKBAR,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 14,
                                );
                              }
                            },
                            label: Text("Sign in with Google"),
                            icon: Image.asset(
                              "assets/images/google.png",
                              height: 35,
                              width: 35,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 236, 235, 235),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
