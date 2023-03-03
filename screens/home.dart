// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_doctor_last/models/brew.dart';
import 'package:e_doctor_last/panels/dashboard.dart';
// ignore: unused_import
import 'package:e_doctor_last/screens/brew_list.dart';
import 'package:e_doctor_last/screens/homescreen.dart';
import 'package:e_doctor_last/screens/settings_form.dart';
import 'package:e_doctor_last/services/auth.dart';
import 'package:e_doctor_last/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: Column(
                children: <Widget>[
                  Dashboard(),
                  CoronaUpdate(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
