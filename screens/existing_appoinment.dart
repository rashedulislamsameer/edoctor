
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_doctor_last/models/user.dart';
import 'package:e_doctor_last/screens/apoinmentinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExistingAppoinment extends StatefulWidget {
  
  

  @override
  _ExistingAppoinmentClassState createState() => _ExistingAppoinmentClassState();
}

class _ExistingAppoinmentClassState extends State<ExistingAppoinment> {
  
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final userinfo= Provider.of<Userid>(context);
    final doc=userinfo.uid;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Doctors Hub',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
        ),
      body: new StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('brews')
            .doc(doc)
            .collection('existingapoinment')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data.docs;
            return new ListView.builder(
                itemCount: doc.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                          //print(doc[index].documentID);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ApoinMentinfo(doc[index].id)),
                          );
                        },
                        
                      child: Card(
                        child: Container(
                margin: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.5,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.new_releases),
                            iconSize: 30.0,
                            color: Colors.red,
                            onPressed: () {}),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              doc[index].data()['doctor_name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
                      ),
                    ),
                  );
                });
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}