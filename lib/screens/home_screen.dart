import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../main.dart';
import '../register_user.dart';
import '/controllers/controllers.dart';
import '/screens/screens.dart';
import '/models/models.dart';
import 'order_screens.dart';

class MyHomeScreen extends StatelessWidget {
  MyHomeScreen({Key? key}) : super(key: key);

  final OrderStatsController orderStatsController =
  Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile POS',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
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
                  ],
                ),
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
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text('Sales Graph', style: TextStyle(fontSize: 25, color: Colors.blueAccent, fontWeight: FontWeight.bold),),
            // FutureBuilder(
            //   future: orderStatsController.stats.value,
            //   builder: (context, AsyncSnapshot<List<OrderStats>> snapshot) {
            //     if (snapshot.hasData) {
            //       return Container(
            //         height: 250,
            //         padding: const EdgeInsets.all(10),
            //         child:
            //         CustomBarChart(
            //           orderStats: snapshot.data!,
            //         ),
            //       );
            //     } else if (snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     }
            //     return const Center(
            //       child: CircularProgressIndicator(
            //         color: Colors.black,
            //       ),
            //     );
            //   },
            // ),
            SizedBox(
              height: 150,
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductsScreen());
                },
                child: const Card(
                  color: Colors.redAccent,
                  child: Center(
                    child: Text('Products', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 17),
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  Get.to(() => SumOrders());
                },
                child: const Card(
                  color: Colors.blueGrey,
                  child: Center(
                    child: Text('Sales', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 17),
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  Get.to(() => CategoryScreen());
                },
                child: const Card(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text('Category', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 17),
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  Get.to(() => RegisterScreen());
                },
                child: const Card(
                  color: Colors.purpleAccent,
                  child: Center(
                    child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    Key? key,
    required this.orderStats,
  }) : super(key: key);

  final List<OrderStats> orderStats;
  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
          id: "orders",
          data: orderStats,
          domainFn: (series, _) =>
              DateFormat('MM-dd-yy').format(series.dateTime).toString(),
          measureFn: (series, _) => series.orders,
          colorFn: (series, _) => series.barColor!)
    ];

    return charts.BarChart(series, animate: true);
  }
}

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()));
}