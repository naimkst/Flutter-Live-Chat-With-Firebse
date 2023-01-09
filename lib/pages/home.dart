import 'package:chatapp_flutter/helper/helper_function.dart';
import 'package:chatapp_flutter/pages/login.dart';
import 'package:chatapp_flutter/pages/profile.dart';
import 'package:chatapp_flutter/pages/search.dart';
import 'package:chatapp_flutter/services/auth_service.dart';
import 'package:chatapp_flutter/services/database_service.dart';
import 'package:chatapp_flutter/widgets/group_tile.dart';
import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Stream? groups;
  bool isLoading = false;
  String groupName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }
  String getName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }

  getUserData() async {
    await HelperFunctions.getUserFullName().then((value) {
      setState(() {
        username = value!;
      });
    });
    await HelperFunctions.getUserEmail().then((value) {
      setState(() {
        email = value!;
      });
    });

    //Get list of snapshop of groups
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((value) => {
              setState(() {
                groups = value;
              })
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
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.deepOrangeAccent,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            username,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {},
            selectedColor: Colors.deepOrangeAccent,
            selected: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(
              Icons.group,
              color: Colors.deepOrangeAccent,
            ),
            title: Text(
              'Groups',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(
                  context,
                  Profile(
                    email: email,
                    username: username,
                  ));
            },
            selectedColor: Colors.deepOrangeAccent,
            selected: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.cancel),
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: () async {
                            await authService.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false);
                          },
                          icon: Icon(Icons.done),
                          color: Colors.green,
                        ),
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
            title: Text(
              'Logout',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ],
      )),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
        elevation: 0.0,
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Create Group',
              textAlign: TextAlign.left,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading == true
                    ? CircularProgressIndicator()
                    : TextField(
                        onChanged: (value) {
                          setState(() {
                            groupName = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Group Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  onPressed: () async {
                    if (groupName != null) {
                      setState(() {
                        isLoading = true;
                        DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                username,
                                FirebaseAuth.instance.currentUser!.uid,
                                groupName);
                        isLoading = false;
                        Navigator.of(context).pop();
                        showSnackbar(context, Colors.green, "Group Added!");
                      });
                    }
                  },
                  child: Text('Add')),
            ],
          );
        });
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                    int reversIndex = snapshot.data['groups'].length - index -1;
                    return GroupTile(
                        groupName: getName(snapshot.data['groups'][reversIndex]),
                        groupId: getId(snapshot.data['groups'][reversIndex]),
                        userName: snapshot.data['fullName'] );
                  });
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Center(
      child: Container(
        child: GestureDetector(
          onTap: () {
            popUpDialog(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle,
                size: 75,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'No Groups',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
