
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_pos/main.dart';
import 'package:mobile_pos/models/user_model.dart';
import 'package:mobile_pos/screens/screens.dart';
import 'package:mobile_pos/test_login.dart';
import 'package:mobile_pos/user_screens/my_home_screen.dart';
// import 'package:mobile_pos/widgets/payment_screen.dart';

import '../catalog_screen.dart';
import '../user_screens/home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  User?user = FirebaseAuth.instance.currentUser;
  UserModel listUser = UserModel();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.listUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: null,
        title: Text("Mobile POS ", style: GoogleFonts.raleway(fontSize: 30, fontWeight: FontWeight.bold)),
        toolbarHeight: 50,
      ),
      body:
      Center(
       child: Padding(
         padding: EdgeInsets.all(5.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Text('You are currently logged in as', style: GoogleFonts.poppins(fontSize: 20),)
             ,Text("${listUser.full_name}", style: GoogleFonts.mouseMemoirs(fontSize: 35),),
             ActionChip(label: Text('Logout', style: GoogleFonts.poppins(fontSize: 15),), onPressed: ()async{
               logout(context);
             })
           ],
         ),
       ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen[100],
              ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget> [
                   Text('Menu', style: GoogleFonts.poppins( fontSize: 35, fontWeight: FontWeight.bold),),
                   Text('${listUser.full_name}', style: GoogleFonts.inter( fontSize:20, fontWeight: FontWeight.w400 ),),
                   Text('${listUser.email}', style: GoogleFonts.inter( fontSize:20, fontWeight: FontWeight.w400 ),),
                 ],
               ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, size: 40,),
              title: RawMaterialButton(
                onPressed: () async{
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyUserApp()));
                },
                child: Text('Transaction', style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),),
              )
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
                leading: Icon(Icons.calculate_outlined, size: 40,),
                title: RawMaterialButton(
                  onPressed: () async{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OrdersScreen()));
                  },
                  child: Text('View Orders', style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),),
                )
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
                leading: Icon(Icons.logout, size: 40,),
                title: RawMaterialButton(
                  onPressed: () async{
                    logout(context);
                  },
                  child: Text('Logout', style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),),
                )
            ),
          ],
        ),
      ),

    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
