import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBase {
  late FirebaseAuth auth;
  late User user;
  late bool isSigned = false;
  late bool isOK = true;
  late CollectionReference players;
  late CollectionReference devices;
  late CollectionReference book;
  late CollectionReference settings;

  DataBase() {
    try {
      print('Database creation...');
      connect();

      auth = FirebaseAuth.instance;
      user = auth.currentUser!;

      print('Database auth user OK');
      isSigned = true;


    } catch (e) {
      print("Database auth user is null: " + e.toString());
      isSigned = false;
      isOK = false;
    }
  }

  connect() {
    //players = FirebaseFirestore.instance.collection('players');
    //devices = FirebaseFirestore.instance.collection('devices');
    //settings = FirebaseFirestore.instance.collection('settings');
    //book = FirebaseFirestore.instance.collection('book');
    //settings.doc("iot_server").get().then((value) => {iotIP = value.data()}); //value.data()['ip']
    print("Database connected!");
  }

}
