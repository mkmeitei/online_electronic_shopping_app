import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteLogic with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> favouriteItem = [];

  void onTapped(String itemId) {
    int existingIndex =
        favouriteItem.indexWhere((element) => element == itemId);

    if (existingIndex == -1) {
      favouriteItem.add(itemId);
    } else {
      favouriteItem.removeAt(existingIndex);
    }
    print(favouriteItem);
    saveFavourites();
    notifyListeners();
  }

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getFavouriteItems(
      List<String> favouriteItemIds) {
    List<DocumentReference<Map<String, dynamic>>> references = favouriteItemIds
        .map((id) => firestore.collection('products').doc(id))
        .toList();

    return CombineLatestStream.list(references.map((ref) {
      return ref.snapshots();
    }));
  }

  // Save favorites to shared preferences
  Future<void> saveFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favouriteItem', favouriteItem);
  }

  // Load saved favorites from shared preferences
  Future<void> loadFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favouriteItem = prefs.getStringList('favouriteItem') ?? [];
    notifyListeners();
  }
}
