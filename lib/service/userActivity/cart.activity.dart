import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:rxdart/rxdart.dart';

class CartLogic with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  List<Map<String, dynamic>> cartItems = [];

  late String orderID;

// get order id
  Future<Map<String, dynamic>?> orderId() async {
    DocumentSnapshot<Map<String, dynamic>> orderSnapshot =
        await firestore.collection('orders').doc(orderID).get();
    if (orderSnapshot.exists) {
      Map<String, dynamic> orderData = orderSnapshot.data()!;
      return orderData;
    } else {
      return null;
    }
  }

// add order
  Future<void> addOrder() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String orderId = firestore.collection("orders").doc().id;

      orderID = orderId;

      List<String> productIds =
          cartItems.map((item) => item["itemid"].toString()).toList();

      print(CartLogic().cartItems);
      print(productIds);
      await firestore.collection("orders").doc(orderId).set({
        "orderDate": FieldValue.serverTimestamp(),
        "orderId": orderId,
        "productId": productIds,
        "status": "pending",
        "totalAmount": calculateOrderTotal(),
        "userId": firebaseAuth.currentUser!.uid,
        "name": prefs.getString('name'),
        "phoneNumber": prefs.getString('phoneNumber'),
        "pincode": prefs.getString('pincode'),
        "city": prefs.getString('city'),
        "state": prefs.getString('state'),
        "locality": prefs.getString('locality'),
        "flatNo": prefs.getString('flatNo'),
        "landmark": prefs.getString('landmark')
      });
      cartItems.clear();
      saveCartItems();
    } catch (e) {
      print("Error adding order: $e");
    }
  }

// calculate total price
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += double.parse(item["price"].toString());
    }

    return totalPrice;
  }

  double calculateOrderTotal() {
    return calculateTotalPrice() + 25;
  }

// save cart items to shared preference
  Future<void> saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJsonList =
        cartItems.map((item) => jsonEncode(item)).toList();
    prefs.setStringList('cartItems', cartItemsJsonList);
    notifyListeners();
  }

// Load cartItems from shared preferences
  Future<void> loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsJsonList = prefs.getStringList('cartItems');

    if (cartItemsJsonList != null) {
      cartItems = cartItemsJsonList
          .map((json) => jsonDecode(json))
          .cast<Map<String, dynamic>>()
          .toList();
      notifyListeners();
    }
  }

// add to items
  void addToCart(
      {required String itemId,
      required String modelname,
      required String price,
      required String imageUrl}) {
    int existingIndex =
        cartItems.indexWhere((element) => element["itemid"] == itemId);

    if (existingIndex == -1) {
      cartItems.add({
        "itemid": itemId,
        "imageUrl": imageUrl,
        "modelName": modelname,
        "price": price
      });
    } else {
      cartItems.removeAt(existingIndex);
    }
    print(cartItems);
    saveCartItems();
    notifyListeners();
  }

// remove items
  void removeItemFromCart(int itemId) {
    cartItems.removeAt(itemId);
    print(cartItems);
    saveCartItems();
    notifyListeners();
  }

  // Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getCartItems(
  //     List<String> cartItemIds) {
  //   List<DocumentReference<Map<String, dynamic>>> references =
  //       cartItems.map((id) => firestore.collection('laptops').doc(id)).toList();

  //   return CombineLatestStream.list(references.map((ref) {
  //     return ref.snapshots();
  //   }));
  // }
}
