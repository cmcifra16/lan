import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth_demo/presentation/custom/clip_path_bg.dart';

class UpdateProfile extends StatefulWidget {
  static const String routeName = '/update_profile';
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  late String _address;
  late String _gender;
  late String _contact;
  late String _email;
  late String _username;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const ClipPathBackground(height: 100),
              TextFormField(
                initialValue: user?.displayName ?? '',
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Full Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: '',
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: '',
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
                onSaved: (value) {
                  _gender = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: '',
                decoration: InputDecoration(labelText: 'Contact'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  } else if (value.length != 9 || value[0] != '9') {
                    return 'Please enter a valid 9-digit phone number that starts with "9"';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contact = value!;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await firestore
                          .collection('users')
                          .doc(user!.uid)
                          .update({
                        'username': _username,
                        'email': _email,
                        'address': _address,
                        'gender': _gender,
                        'contact': _contact,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Profile updated successfully')));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error updating data')));
                    }
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
