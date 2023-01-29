import 'package:alert/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_pos/models/user_model.dart';
import 'package:mobile_pos/screens/home_screen.dart';
import 'package:mobile_pos/screens/profile_screen.dart';

void main(){
  runApp( const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterScreen(),
    );
  }
}



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text( "Employee Registration",
              style: TextStyle( decoration: TextDecoration.none,fontSize: 35, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
            )
          ),
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        child: (
                       Form(child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            style: TextStyle( fontSize: 15),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_box),
                              labelText: 'Full name',
                            ),
                            validator: (value){
                              if(value == null){
                                return "Field is required.";
                              }
                            }
                          ),
                          SizedBox(
                            height: 15
                          ),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              style: TextStyle( fontSize: 15),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                labelText: 'Email address',
                              ),
                              validator: (value){
                                if(_emailController == null){
                                  return "Field is required.";
                                }
                              }
                          ),
                          SizedBox(
                              height: 15
                          ),
                          TextFormField(
                              controller: _contactController,
                              keyboardType: TextInputType.number,
                              style: TextStyle( fontSize: 15),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                labelText: 'Phone number',
                              ),
                              validator: (value){
                                if(value == null){
                                  return "Field is required.";
                                }
                              }
                          ),
                          SizedBox(
                              height: 15
                          ),
                          TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: TextStyle( fontSize: 15),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
                                labelText: 'Password',
                              ),
                              validator: (value){
                                if(value == null){
                                  return "Field is required.";
                                }
                              }
                          ),
                          SizedBox(
                              height: 15
                          ),
                          Container(
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget> [
                                ElevatedButton(
                                   onPressed: ()  {
                                     signUp(_emailController.text, _passwordController.text);
                                     showDialog(context: context, builder: (BuildContext context){
                                       return AlertDialog(
                                         title: Text('Notice'),
                                         content: Text('Account created succesfully.'),
                                         actions: [
                                           FlatButton(
                                             onPressed: () {
                                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomeScreen()));
                                             },
                                             child: Text('Okay'),
                                           )
                                         ],
                                       );
                                     });
                                   },
                                   child: const Text('Submit', style: TextStyle( fontSize: 15))
                               ),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.redAccent
                                  ),
                                   onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomeScreen()));
                                   },
                                   child: const Text('Back To Previous Page', style: TextStyle( fontSize: 15),)
                               ),
                             ]
                           )
                          )

                       ],
                       ))
                        ),
                      ),
                  )
                ],
              )
          ),
        ],
      )
    );
  }

  void signUp(String email, String password) async{
    if (_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            postDetailsToFireStore()
      }).catchError((e){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text('Registration Error'),
            content: Text('Fields cannot be empty!'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: Text('Accept'),
              )
            ],
          );
        });
      });
    }
  }
  postDetailsToFireStore() async{

    FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.full_name = _nameController.text;
    userModel.phone_number = _contactController.text;

    await firebaseFireStore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
  }
}
