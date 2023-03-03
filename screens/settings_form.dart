
// ignore: avoid_web_libraries_in_flutter
import 'package:e_doctor_last/models/user.dart';
import 'package:e_doctor_last/services/database.dart';
import 'package:e_doctor_last/shared/constants.dart';
import 'package:e_doctor_last/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> bloodgroup = ['AB-negative', 'B-negative', 'AB-positive', 'A-negative', 'O-negative','B-positive','A-positive','O-positive'];

  // form values
  String _currentName;
  String _currentbloodgroup;
  String _currentproblem;

  @override
  Widget build(BuildContext context) {

    final userinfo= Provider.of<Userid>(context);

    return StreamBuilder<UserData>(
      
      stream: DatabaseService(uid: userinfo.uid).userdata,

      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name ,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                // DropdownButtonFormField(
                //   value: _currentbloodgroup ?? userData.bloodgroup,
                //   decoration: textInputDecoration,
                //   items: bloodgroup.map((bloodgroup) {
                //     return DropdownMenuItem(
                //       value: bloodgroup,
                //       child: Text('$bloodgroup bloodgroup' ),
                //     );
                //   }).toList(),
                //   onChanged: (val) => setState(() => _currentbloodgroup = val ),
                // ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: userData.problem,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please your previous cases' : null,
                  onChanged: (val) => setState(() => _currentproblem = val),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: userData.uid).updateUserData(
                        _currentbloodgroup ?? userData.bloodgroup,
                        _currentName ?? userData.name,
                        _currentproblem ?? userData.problem,
                        );
                        Navigator.pop(context);
                    } else {
                    }
                    
                  }
                ),
              ],
            ),
          );
        }
        else{
          return Loading();
        }
        }

        
      
    );
  }
}