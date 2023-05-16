import 'package:firebase_auth_demo/screens/hotline.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_demo/presentation/custom/clip_path_bg.dart';
import 'edit.dart';
import 'profile-update.dart';

class profile extends StatefulWidget {
  static String routeName = '/home2';
  const profile({Key? key}) : super(key: key);

  @override
  _profile createState() => _profile();
}

class _profile extends State<profile> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Drawer(
      width: MediaQuery.of(context).size.width / 1.10,
      child: Column(
        children: [
          const ClipPathBackground(height: 200),
          FutureBuilder<DocumentSnapshot>(
            future: firestore.collection('users').doc(user.uid).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                final name = data['username'];
                final age = data['age'];
                imageUrl = data['profile'];
                return Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: (ImageUploadScreen()),
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 0),
                              Text(
                                age,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      _DashboardButton(
                        icon: Icons.edit,
                        label: 'edit profile',
                        width: 400,
                        iconSize: 30,
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            builder: (BuildContext context) {
                              return Scaffold(
                                resizeToAvoidBottomInset: true,
                                body: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: UpdateProfile(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      _DashboardButton(
                        icon: Icons.contact_phone,
                        label: 'Hotline Number',
                        width: 400,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => hotline()),
                          );
                        },
                      ),
                      SizedBox(height: 200),
                      _DashboardButton(
                        icon: Icons.logout,
                        label: 'logout',
                        width: 400,
                        iconSize: 30,
                        onPressed: () {
                          context.read<FirebaseAuthMethods>().signOut(context);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _DashboardButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final double width;
  final double iconSize;
  final VoidCallback onPressed;

  const _DashboardButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.width,
    required this.iconSize,
  }) : super(key: key);

  @override
  __DashboardButtonState createState() => __DashboardButtonState();
}

class __DashboardButtonState extends State<_DashboardButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEvent event) => setState(() => _isHovering = true),
      onExit: (PointerEvent event) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: widget.width,
          padding: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                color: _isHovering
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(255, 85, 83, 83),
                size: widget.iconSize,
              ),
              const SizedBox(width: 5),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovering
                      ? Color.fromARGB(255, 0, 0, 0)
                      : Color.fromARGB(255, 85, 83, 83),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
