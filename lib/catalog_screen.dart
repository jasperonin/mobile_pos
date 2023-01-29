
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/screens/profile_screen.dart';
//import 'package:mobile_pos/widgets/catalog_products.dart';

import 'cart_screen.dart';
import 'main.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var controller;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transaction',
          style: GoogleFonts.poppins( fontSize: 25, fontWeight: FontWeight.bold ),
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
                children: [
                  Text('Menu', style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              onTap: () async {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              title: Text(
                'Go Back', style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              onTap: () async {
                logout(context);
              },
              title: Text(
                'Logout', style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //CatalogProducts(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CartScreen()));
                },
                child: Text('Go to Cart')
            ),
          ],
          
        ),
      ),
    );
  }
}
