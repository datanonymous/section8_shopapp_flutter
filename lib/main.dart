import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './providers/cart_provider.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './screens/cart_screen.dart';
import './providers/orders_provider.dart';
import './screens/orders_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        ChangeNotifierProvider.value(
//          value: ProductsProvider(),
//        ),
//        ChangeNotifierProvider.value(
//          value: CartProvider(),
//        ),
//use this when creating a new instance of an object
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
//use this if you are iterating across an existing object and changing values (like listview and gridview)
//        ChangeNotifierProvider.value(
//          value: CartProvider(),
//        ),
        ChangeNotifierProvider.value(
          value: OrdersProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
//        visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx)=> OrdersScreen(),
          UserProductsScreen.routeName: (ctx)=> UserProductsScreen(),
          EditProductScreen.routeName: (ctx)=> EditProductScreen(),
        },
      ),
    );
  }
}
