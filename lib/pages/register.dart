import 'package:chatapp_flutter/helper/helper_function.dart';
import 'package:chatapp_flutter/pages/home.dart';
import 'package:chatapp_flutter/pages/login.dart';
import 'package:chatapp_flutter/services/auth_service.dart';
import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String fullName = '';
  String password = '';
  bool _isLoading = false;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Groupie!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Create an account to join the fun!",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Image.asset('assets/images/login.png'),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Full Name',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.deepOrange,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your full name'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.deepOrange,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.deepOrange,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          return value!.length >=  6
                              ? null
                              : "Please enter a password with 6+ characters";
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              register();
                            },
                            child: Text(
                              'Sign In',
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "You already have an account? ",
                          children: [
                            TextSpan(
                              text: "Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, LoginPage());
                                },
                              style: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      print('Login');
      setState(() {
        _isLoading = true;
      });
      await authService.registerWithEmailAndPassword(fullName, email, password)
      .then((value) async{
        if(value == true){
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserName(fullName);
          await HelperFunctions.saveUserEmail(email);
          showSnackbar(context, Colors.green, "Successfully registered");
          setState(() {
            _isLoading = false;
          });
          nextScreenReplace(context, Home());
        }else{
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });

    }
  }
}
