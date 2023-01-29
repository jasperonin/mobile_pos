import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pos/screens/screens.dart';

import '../controllers/order_controller.dart';
import '../models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
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
                    Get.to(() => ProfileScreen());
                  },
                  child: Text('Go back', style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),),
                )
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: orderController.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrderCard(order: orderController.pendingOrders[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        top: 10.0,
        right: 10.0,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ID: ${order.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-yy').format(order.createdAt),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Service Fee',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\P${ order.deliveryFee}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\P${order.total}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  order.isAccepted
                      ? ElevatedButton(
                    onPressed: () {
                      orderController.updateOrder(
                        order,
                        "isDelivered",
                        !order.isDelivered,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text(
                      'Deliver',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
                      : ElevatedButton(
                    onPressed: () {
                      orderController.updateOrder(
                        order,
                        "isAccepted",
                        !order.isAccepted,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      orderController.updateOrder(
                        order,
                        "isCancelled",
                        !order.isCancelled,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}