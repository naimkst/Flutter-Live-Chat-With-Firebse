import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                  "Login now to join the fun!",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Image.asset('assets/images/login.png'),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.deepOrange,
                    ),
                  ),
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (value){
                    return value!.length > 6
                        ? null
                        : "Please enter a password with 6+ characters";
                  },
                ),
                ElevatedButton(onPressed: (){}, child: Text(
                  'Login'
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  login(){
    if(formKey.currentState!.validate()){
      print('Login');
    }
  }
}
