import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; //allows required decorator
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus(String authToken) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite; //! inverts the value
    notifyListeners();
    final url = 'https://flutterko-74940.firebaseio.com/products/$id.json?auth=$authToken';
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      //https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
      if(response.statusCode >=400){
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
