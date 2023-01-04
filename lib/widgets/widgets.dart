import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
 labelStyle: TextStyle(color: Colors.black),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.0),

  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),

  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),

  ),
);

void nextScreen(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void showSnackbar(context, color, message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}