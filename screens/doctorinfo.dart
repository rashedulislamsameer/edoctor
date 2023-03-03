import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_doctor_last/models/user.dart';
import 'package:e_doctor_last/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorInfo extends StatefulWidget {
  final doc;
  DoctorInfo(this.doc);
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userinfo = Provider.of<Userid>(context);
    final doc = userinfo.uid;

    String doctorName;
    // ignore: unused_local_variable
    String apoinTime;
    _fetch() async {
      if (doc != null)
        await FirebaseFirestore.instance
            .collection('departmentlist')
            .doc(widget.doc)
            .get()
            .then((ds) {
          doctorName = ds.data()['doctor_name'];
          apoinTime = ds.data()['name'];
          print(doctorName);
        }).catchError((e) {
          print(e);
        });
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('brews')
                .doc(doc)
                .collection('existingapoinment')
                .add({
              'doctor_name': textEditingController.text,
              'blood group': textEditingController2.text,
              'time': textEditingController3.text,
              'description': textEditingController4.text,
            });
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.book,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text(
            'name',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
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
                          )
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
                        'select appointment time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
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
                                "05.00 PM",
                                style: TextStyle(fontSize: 20.0),
                              ),
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
                                "05.30 PM",
                                style: TextStyle(fontSize: 20.0),
                              ),
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
                                "6.00 PM",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
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
                                "07.00 PM",
                                style: TextStyle(fontSize: 20.0),
                              ),
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
                                "08.30 PM",
                                style: TextStyle(fontSize: 20.0),
                              ),
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
                                "9.00 PM",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              'put your information down below',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  hintText: 'name',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextField(
                              controller: textEditingController2,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  hintText: 'blood group',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: textEditingController3,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  hintText: 'time',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextField(
                              controller: textEditingController4,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  hintText: 'description',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              );
            } else {
              return Loading();
            }
          },
        ));
  }
}
