import 'package:chatapp_flutter/helper/helper_function.dart';
import 'package:chatapp_flutter/pages/home.dart';
import 'package:chatapp_flutter/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyAboT9nCkPYVblyxtpU6eBEwwFayRP5HRg",
          appId: "1:181538328854:web:d6da133c1fba8e946f8037",
          messagingSenderId: "181538328854",
          projectId: "chat-app-3cad9",
        )
    );
  }else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isSignIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoginStatus();
  }

  getUserLoginStatus() async {
    await HelperFunctions.getUserLoginStatus().then((value){
      if(value != null){
        setState(() {
          _isSignIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isSignIn ? Home() : LoginPage(),
    );
  }
}
