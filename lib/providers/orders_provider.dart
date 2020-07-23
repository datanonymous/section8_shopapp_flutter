import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  OrdersProvider(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://flutter-update.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title'],
            ),
          )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://flutter-update.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
          'id': cp.id,
          'title': cp.title,
          'quantity': cp.quantity,
          'price': cp.price,
        })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}







//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import './cart_provider.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//
//class OrderItem {
//  final String id;
//  final double amount;
//  final List<CartItem> products;
//  final DateTime dateTime;
//
//  OrderItem({
//    @required this.id,
//    @required this.amount,
//    @required this.products,
//    @required this.dateTime,
//  });
//}
//
//class OrdersProvider with ChangeNotifier {
//  List<OrderItem> _orders = [];
//  final String authToken;
//  final String userId;
//
//  OrdersProvider(this.authToken, this.userId, this._orders);
//
//  List<OrderItem> get orders {
//    return [..._orders]; //spread operator
//  }
//
//  Future<void> fetchAndSetOrders() async {
//    final url = 'https://flutterko-74940.firebaseio.com/orders/$userId.json?auth=$authToken';
//    final response = await http.get(url);
//    print(json.decode(response.body));
//    final List<OrderItem> loadedOrders = [];
//    final extractedData = json.decode(response.body) as Map<String, dynamic>;
//    print('extracted data:');
//    print(extractedData);
//    if(extractedData == null){
//      return;
//    }
//    extractedData.forEach((key, value) {
//      loadedOrders.add(OrderItem(
//          id: key,
//          amount: value['amount'],
//          products: (value['products'] as List<dynamic>)
//              .map((e) => CartItem(
//                  id: e['id'],
//                  price: e['price'],
//                  quantity: e['quantity'],
//                  title: e['title']))
//              .toList(),
//          dateTime: DateTime.parse(value['dateTime'])));
//    });
//    _orders = loadedOrders.reversed.toList();
//    notifyListeners();
//  }
//
//  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
//    final url = 'https://flutterko-74940.firebaseio.com/orders/$userId.json?auth=$authToken';
//    final timestamp = DateTime.now();
//    final response = await http.post(url,
//        body: json.encode({
//          'amount': total,
//          'dateTime': timestamp.toIso8601String(),
//          'products': cartProducts
//              .map((e) => {
//                    'id': e.id,
//                    'title': e.title,
//                    'quantity': e.quantity,
//                    'price': e.price,
//                  })
//              .toList(),
//        }));
//    _orders.insert(
//      0,
//      OrderItem(
//          id: json.decode(response.body)['name'],
//          amount: total,
//          products: cartProducts,
//          dateTime: DateTime.now()),
//    );
//    notifyListeners();
//  }
//}
