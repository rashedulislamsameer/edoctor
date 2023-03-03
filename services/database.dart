import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_doctor_last/models/brew.dart';
import 'package:e_doctor_last/models/user.dart';

class DatabaseService {
   final String uid;
  DatabaseService({ this.uid });

  
  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  final CollectionReference existingapointment = FirebaseFirestore.instance.collection('brews').doc().collection('existingapoinment');

  Future<void> updateUserData(String bloodgroup, String name, String problem) async {
    return await brewCollection.doc(uid).set({
      'bloodgroup': bloodgroup,
      'name': name,
      'problem': problem,
    });
  }

  Future <void>updateapointmentdata(String name,String time,String bloodgroup)async{
    return await existingapointment.doc(uid).collection('existingapoinment').doc().set({
      'name' : name,
      'time' : time,
      'bloodgroup' : bloodgroup,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
        return Brew(
          name: doc.data()['name'] ?? '',
          bloodgroup: doc.data()['bloodgroup'] ?? '',
          problem: doc.data()['problem'] ?? '0',
        );
    }).toList();
  }

    //user data from snapshot

    UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        bloodgroup: snapshot.data()['bloodgroup'],
        problem: snapshot.data()['problem'],
        
        );
    }

    // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot)
    ;
  }

  //get user doc stream
  Stream<UserData> get userdata{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  
}