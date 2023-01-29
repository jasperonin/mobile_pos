import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? uid;
  String? role;
  String? full_name;
  String? email;
  String? phone_number;

  UserModel({this.uid,this.role, this.full_name, this.email, this.phone_number});

  // get data from database
factory UserModel.fromMap(map){
  return UserModel(
    uid: map['uid'],
    full_name: map['full_name'],
    email: map['email'],
    phone_number: map['phone_number'],
    role: map['role'],
  );
}

Map<String, dynamic> toMap(){
  return {
    'uid': uid,
    'full_name': full_name,
    'email': email,
    'phone_number': phone_number,
    'role': role,
  };
}


}