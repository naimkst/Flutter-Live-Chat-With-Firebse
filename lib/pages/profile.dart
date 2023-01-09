import 'package:chatapp_flutter/helper/helper_function.dart';
import 'package:chatapp_flutter/pages/login.dart';
import 'package:chatapp_flutter/services/auth_service.dart';
import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  String username;
  String email;
   Profile({Key? key, required this.email, required this.username}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Profile', style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),),
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            children: [
              Icon(Icons.account_circle, size: 150, color: Colors.deepOrangeAccent,),
              SizedBox(height: 10,),
              Text(widget.username, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(widget.email, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
              SizedBox(height: 20,),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: (){
                },
                selectedColor: Colors.deepOrangeAccent,
                selected: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.group),
                title: Text('Groups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),),
              ),
              ListTile(
                onTap: (){
                },
                selectedColor: Colors.deepOrangeAccent,
                selected: true,
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
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(height: 10,),
            Text(widget.username, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text(widget.email, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
          ],
        ),
      ),
    );
  }
}
