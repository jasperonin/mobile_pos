import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_pos/models/models.dart';
import 'package:mobile_pos/user_models/models.dart';
import '../../screens/profile_screen.dart';
import '../../services/database_service.dart';
import '../../services/storage_service.dart';
import '/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/cart/cart_bloc.dart';
import 'package:intl/intl.dart';


class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';
  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    int orderNumber = Random().nextInt(1000);
    int csNumber = Random().nextInt(1000);
    return BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if(state is CartLoaded) {
            return Scaffold(
              appBar: CustomAppBar(title: 'Order Confirmation'),
              bottomNavigationBar: CustomNavBar(screen: routeName),
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: Colors.black,
                          width: double.infinity,
                          height: 300,
                        ),
                        Positioned(
                          left: (MediaQuery.of(context).size.width - 100) / 2,
                          top: 125,
                          child: SvgPicture.asset(
                            'assets/svgs/garlands.svg',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Positioned(
                          top: 250,
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Your order is complete!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thank you for your purchase.',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'ORDER NUMBER: ${orderNumber}',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          OrderSummary(),

                          SizedBox(height: 20),
                          Container(
                              margin: EdgeInsets.only(left: 75),
                              child:
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    minimumSize: Size(15, 25),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    textStyle:
                                    TextStyle( fontSize: 30, color: Colors.white )
                                ),
                                onPressed: () {
                                  database.addOrder(Order
                                    (
                                      id: orderNumber,
                                      customerId: csNumber,
                                      productIds: [2],
                                      deliveryFee: double.parse(state.cart.deliveryFeeString),
                                      subtotal: double.parse(state.cart.subtotalString),
                                      total: double.parse(state.cart.totalString),
                                      isAccepted: false,
                                      isDelivered: false,
                                      isCancelled: false,
                                      createdAt: DateTime.now())
                                  );
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
                                },
                                child: Text('Confirm Order'),
                              )
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('Something went wrong.');
          }
        }
    );
  }

}
