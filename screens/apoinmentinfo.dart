import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_doctor_last/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApoinMentinfo extends StatefulWidget {
  final doc1;
  ApoinMentinfo(this.doc1);
  @override
  _ApoinMentinfoState createState() => _ApoinMentinfoState();
}

class _ApoinMentinfoState extends State<ApoinMentinfo> {
  @override
  Widget build(BuildContext context) {
    final userinfo = Provider.of<Userid>(context);
    final docuid = userinfo.uid;
    // ignore: unused_local_variable
    final db = FirebaseFirestore.instance;

    String doctorName;
    String apoinTime;
    _fetch() async {
      if (docuid != null)
        await FirebaseFirestore.instance
            .collection('brews')
            .doc(docuid)
            .collection('existingapoinment')
            .doc(widget.doc1)
            .get()
            .then((ds) {
          doctorName = ds.data()['doctor_name'];
          apoinTime = ds.data()['time'];
          print(doctorName);
        }).catchError((e) {
          print(e);
        });
    }

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
        body: FutureBuilder<QuerySnapshot>(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "doctor name : $doctorName",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        'General Surgery ',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Dhaka medical college',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            'neuro surgeon department',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'assitant proffessor',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'BMDC reg -35447',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Text(
                          'Consultant fee = 500 BDT',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Schedule',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "apoinment time",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                FlatButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  disabledColor: Colors.black,
                                  disabledTextColor: Colors.black,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.redAccent,
                                  onPressed: () {
                                    /*...*/
                                  },
                                  child: Text(
                                    "$apoinTime",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50.0),
                          ],
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: Icon(Icons.call),
                      backgroundColor: Colors.green,
                    ),
                  ],
                );
              } else {
                return LinearProgressIndicator();
              }
            }));
  }
}
