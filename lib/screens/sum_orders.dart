import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<Text> getOrder() {
  var df = DateFormat.yMMMd().format(DateTime.now());
  final databaseReference = FirebaseFirestore.instance;
  return databaseReference.collection("orders").get().then((snapshot) {
    double sum = 0;
    for (var document in snapshot.docs) {
      double value = document.data()['total'] as double;
      sum += double.parse(value.toString());
    }
    return Text('Sales as of $df is '+ 'P'+sum.toString(), style: TextStyle(fontSize: 15),) as Text;
  });
}


class SumOrders extends StatelessWidget {
  const SumOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Mobile POS', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: Text('Sales', style:TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
            ),

            SizedBox(
              child: FutureBuilder<Text>(
                future: getOrder(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      child: snapshot.data,
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("orders").orderBy('createdAt', descending: true).where('isDelivered', isEqualTo: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (!snapshot.hasData){
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }

                return Container(
                  height: 580,
                  width: 500,
                  child: ListView(
                      children: snapshot.data!.docs.map((snap) {
                        Timestamp timestamp = snap['createdAt'];
                        DateTime date = timestamp.toDate();
                        double Total = snap['total'];
                        List<String> list = Total.toString().split('.');

                        int order_id = snap['id'];
                        getOrder();
                        return Card(
                          child:
                          ListTile(
                            //leading: Text(snap['age'].toString()),
                            title: Text('Date '+DateFormat('dd-MM-yy').format(date), style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                            subtitle: Text('Order ID:'+ order_id.toString() +'\n'+'Sale: '+ Total.toString()),
                          ),
                        );
                      }).toList()
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}



