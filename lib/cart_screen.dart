
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/catalog_screen.dart';
// import 'package:mobile_pos/widgets/cart_products.dart';
// import 'package:mobile_pos/widgets/cart_total.dart';

import 'main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text ('Check out'),
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
                    MaterialPageRoute(builder: (context) => CatalogScreen()));
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

      body: Column(
        children: [

        ],
      ),
    );
  }
}
