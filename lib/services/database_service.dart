import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_pos/models/models.dart';
import '../user_models/category_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Order>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getPendingOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('isCancelled', isEqualTo: false)
        .where('isDelivered', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Products>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Products.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Categories>> getCategories() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Categories.fromSnapshot(doc)).toList();
    });
  }

  Future<List<OrderStats>> getOrderStats() {
    return _firebaseFirestore
        .collection('order_stats')
        .orderBy('dateTime')
        .get()
        .then((querySnapshot) => querySnapshot.docs
        .asMap()
        .entries
        .map((entry) => OrderStats.fromSnapshot(entry.value, entry.key))
        .toList());
  }

  Future<void> addProduct(Products product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> addCategory(Categories category) {
    return _firebaseFirestore.collection('categories').add(category.toMap());
  }

  Future<void> addOrder(Order order) {
    return _firebaseFirestore.collection('orders').add(order.toMap());
  }

  Future<void> deleteProduct(
      Products product,
      ) {
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) => {
      querySnapshot.docs.first.reference.delete()
    });
  }

  Stream<List<Order>> sumOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('createdAt', isEqualTo: DateTime.now())
        .where('isDelivered', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }


  Future<void> updateField(
      Products product,
      String field,
      dynamic newValue,
      ) {
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) => {
      querySnapshot.docs.first.reference.update({field: newValue})
    });
  }

  Future<void> updateOrder(
      Order order,
      String field,
      dynamic newValue,
      ) {
    return _firebaseFirestore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((querySnapshot) => {
      querySnapshot.docs.first.reference.update({field: newValue})
    });
  }
}