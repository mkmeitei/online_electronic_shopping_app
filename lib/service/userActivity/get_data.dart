import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetData with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String name = '';
  String locality = '';
  String city = '';
  String state = '';
  String pincode = '';
  String phone = '';

  void getAddressData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    name = pref.getString('name') ?? '';
    locality = pref.getString('locality') ?? '';
    city = pref.getString('city') ?? '';
    state = pref.getString('state') ?? '';
    pincode = pref.getString('pincode') ?? '';
    phone = pref.getString('phoneNumber') ?? '';
    notifyListeners();
  }

// get popular products
  Stream<QuerySnapshot<Map<String, dynamic>>> getPopularProducts() {
    return firestore
        .collection('products')
        .where('popularity', isGreaterThan: 300)
        .orderBy('popularity', descending: true)
        .limit(10)
        .snapshots();
  }

// get products for same category
  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts(
      String productCategory) {
    return firestore
        .collection('products')
        .where('category', isEqualTo: productCategory)
        .snapshots();
  }

// get a single product
  Stream<DocumentSnapshot<Map<String, dynamic>>> getSingleProduct(
      String docId) {
    return firestore.collection('products').doc(docId).snapshots();
  }
}
