import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_doctor_last/screens/doctorinfo.dart';
import 'package:e_doctor_last/shared/loading.dart';
import 'package:flutter/material.dart';

class DepartmentList extends StatefulWidget {
  @override
  _DepartmentListState createState() => _DepartmentListState();
}

class _DepartmentListState extends State<DepartmentList> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: db.collection('departmentlist').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var doc = snapshot.data.docs;
                return new ListView.builder(
                    itemCount: doc.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: GestureDetector(
                          onTap: () {
                            //print(doc[index].documentID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorInfo(doc[index].id)),
                            );
                          },
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                        children: <Widget>[
                                          Text(
                                            doc[index].data()['name'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }
}
