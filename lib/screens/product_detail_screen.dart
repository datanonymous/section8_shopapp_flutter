import 'package:flutter/material.dart';
import 'package:section8_shopapp_flutter/providers/products_provider.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'product-detail';

//  final String title;
//  ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    //filtering logic done in products_provider class
    //final loadedProduct = Provider.of<ProductsProvider>(context).items.firstWhere((element) => element.id==productId);
    //listen: false because you don't expect products to change
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
