

import 'package:e_doctor_last/screens/authenticate/authenticate.dart';
import 'package:e_doctor_last/screens/home.dart';
import 'package:e_doctor_last/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  final userinfo= Provider.of<Userid>(context);
    print(userinfo);
    if (userinfo ==null) {
      return Authenticate(); 
    } else {
    }
    return Home(); 
  }
}