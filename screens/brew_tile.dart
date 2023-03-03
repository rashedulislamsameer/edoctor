
import 'package:e_doctor_last/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({ this.brew });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.bloodgroup} sugar(s)'),
        ),
      ),
    );
  }
}