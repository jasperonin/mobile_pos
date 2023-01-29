import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                        double Total = 0.0;
                        int order_id = snap['id'];
                        if(date == date) {
                          Total = snap['total'];
                          print(Total);
                        }
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
  void getOrder() {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    _firebaseFirestore.collection('products').where('quantity').get().then((value){
      value.docs.forEach((result) {
        _firebaseFirestore.collection('orders')
        .doc(result.id)
        .get();

        print(result.data());
      });
    });
  }
}



