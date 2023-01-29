import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mobile_pos/admin_main.dart';
import 'package:mobile_pos/screens/profile_screen.dart';
import 'package:mobile_pos/register_user.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:alert/alert.dart';
import 'package:mobile_pos/screens/products_screen.dart';
import 'package:mobile_pos/screens/screens.dart';


void main(){
  runApp( const Main());
}


class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
    home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

Future<FirebaseApp> _initializeFirebase() async{
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Login function
  static Future<User?> loginUsingEmailPassword({ required String email,  required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text('System Error'),
            content: Text('Incorrect Username or Password'),
            actions: [
              FlatButton(
                onPressed: () { Navigator.of(context).pop(); },
                child: Text('Accept'),
                
              )
            ],
          );
        });
      }

    }
    return user;
  }

  @override
  Widget build (BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Mobile POS", style:
          TextStyle(
              color: Colors.blueGrey,
              fontSize: 28,
              fontWeight: FontWeight.bold
          ),),
          Text('Employee Login',
          style: TextStyle(
            fontSize: 44,
            color: Colors.deepOrangeAccent,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(
            height: 25,
          ),
          Form(
            key : _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (_emailController){
                    if(_emailController==null || _emailController.isEmpty){
                      return 'Please add a value';
                    }
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "Enter Email Address",
                      prefixIcon: Icon(Icons.mail, color: Colors.black26)
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Enter Password",
              prefixIcon: Icon(Icons.lock, color: Colors.black26)
            ),
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: null,
              child: const Text('Admin Screen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AdminHomeScreen()));
              },
            ),
          ),
          SizedBox(
              height: 25.0,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
                fillColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
                onPressed: () async {
                  User?user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                  print(user);
                  if(user != null){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
                  }
                }
                , child: const Text('Sign In', style: TextStyle( color: Colors.white, fontSize: 18),)),
          )
        ],
      ),
    );
  }
}

