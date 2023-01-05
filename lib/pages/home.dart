import 'package:chatapp_flutter/helper/helper_function.dart';
import 'package:chatapp_flutter/pages/login.dart';
import 'package:chatapp_flutter/pages/profile.dart';
import 'package:chatapp_flutter/pages/search.dart';
import 'package:chatapp_flutter/services/auth_service.dart';
import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
  String username = '';
  String email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    await HelperFunctions.getUserFullName().then((value){
      setState(() {
        username = value!;
      });
    });
    await HelperFunctions.getUserEmail().then((value){
      setState(() {
        email = value!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(context, SearchPage());
            },
            icon: Icon(Icons.search),
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: const Text(
          'Group Chat',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(Icons.account_circle, size: 150, color: Colors.deepOrangeAccent,),
            SizedBox(height: 10,),
            Text(username, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text(email, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
            SizedBox(height: 20,),
            Divider(
              height: 2,
            ),
            ListTile(
              onTap: (){
              },
              selectedColor: Colors.deepOrangeAccent,
              selected: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group, color: Colors.deepOrangeAccent,),
              title: Text('Groups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),),
            ),
            ListTile(
              onTap: (){
                nextScreen(context, Profile());
              },
              selectedColor: Colors.deepOrangeAccent,
              selected: false,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.person),
              title: Text('Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),),
            ),
            ListTile(

              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                    context: context, builder: (context){
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.cancel), color: Colors.red,),
                      IconButton(onPressed: () async{
                       await authService.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginPage()),
                              (route) => false);
                      }, icon: Icon(Icons.done), color: Colors.green,),
                    ],
                  );
                });
                // await authService.signOut().whenComplete(() => {
                //   nextScreenReplace(context, LoginPage())
                // });
              },
              selectedColor: Colors.deepOrangeAccent,
              selected: false,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),),
            ),
          ],
        )
      ),
      body: GestureDetector(
        onTap: () {
          authService.signOut();
          nextScreen(context, LoginPage());
        },
        child: const Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
