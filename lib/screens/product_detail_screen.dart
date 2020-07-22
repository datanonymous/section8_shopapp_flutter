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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                //lecture #280
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
