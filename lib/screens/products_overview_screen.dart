import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart_provider.dart';
import './cart_screen.dart';
import '../providers/products_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}





//import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import '../providers/products_provider.dart';
//import './cart_screen.dart';
//import '../providers/cart_provider.dart';
//import '../widgets/app_drawer.dart';
//import '../widgets/badge.dart';
//import '../widgets/products_grid.dart';
//
//enum FilterOptions {
//  Favorites,
//  All,
//}
//
//class ProductsOverviewScreen extends StatefulWidget {
//  @override
//  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
//}
//
//class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
//  var _showOnlyFavorites = false;
//  var currentPage;
//  var _isInit = true;
//  var _isLoading = false;
//
//  @override
//  void initState() {
////    Provider.of<ProductsProvider>(context).fetchAndSetProducts(); //won't work!
////    Future.delayed(Duration.zero).then((value) {
////      Provider.of<ProductsProvider>(context).fetchAndSetProducts();
////    }); //this is a hack, would also work for modal route
//    super.initState();
//  }
//
//  @override
//  void didChangeDependencies() {
//    if (_isInit) {
//      setState(() {
//        _isLoading = true;
//      });
//      Provider.of<ProductsProvider>(context)
//          .fetchAndSetProducts()
//          .then((value) {
//        setState(() {
//          _isLoading = false;
//        });
//      });
//    }
//    _isInit = false;
//    // occurs more frequently than initState (once), runs after widget is initialized but before build is run for the first time
//    super.didChangeDependencies();
//  }
//
//  @override
//  Widget build(BuildContext context) {
////    final productsContainer = Provider.of<ProductsProvider>(context, listen: false);
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('MyShop'),
//        actions: <Widget>[
//          PopupMenuButton(
//            onSelected: (FilterOptions selectedValue) {
//              print(selectedValue);
//              setState(() {
//                if (selectedValue == FilterOptions.Favorites) {
////                productsContainer.showFavoritesOnly();
//                  _showOnlyFavorites = true;
//                } else {
////                productsContainer.showAll();
//                  _showOnlyFavorites = false;
//                }
//              });
//            },
//            icon: Icon(Icons.more_vert),
//            itemBuilder: (_) => [
//              PopupMenuItem(
//                child: Text('Only Favorites'),
//                value: FilterOptions.Favorites,
//              ),
//              PopupMenuItem(
//                child: Text('Show all'),
//                value: FilterOptions.All,
//              ),
//            ],
//          ),
//          Consumer<CartProvider>(
//            builder: (_, cart, ch) => Badge(
//              child: ch,
//              value: cart.itemCount.toString(),
//            ),
//            child: IconButton(
//              icon: Icon(
//                Icons.shopping_cart,
//              ),
//              onPressed: () {
//                Navigator.of(context).pushNamed(CartScreen.routeName);
//              },
//            ),
//          ),
//        ],
//      ),
//      drawer: AppDrawer(),
//      body: _isLoading
//          ? Center(
//              child: CircularProgressIndicator(),
//            )
//          : ProductsGrid(_showOnlyFavorites),
//      //https://pub.dev/packages/fancy_bottom_navigation
//      bottomNavigationBar: FancyBottomNavigation(
//        tabs: [
//          TabData(iconData: Icons.home, title: 'Home'),
//          TabData(iconData: Icons.search, title: 'Search'),
//          TabData(iconData: Icons.shopping_cart, title: 'Shopping Cart'),
//        ],
//        onTabChangedListener: (position) {
//          setState(() {
//            currentPage = position;
//          });
//        },
//        initialSelection: 0,
//        circleColor: Colors.pink,
//        activeIconColor: Colors.white,
//        inactiveIconColor: Colors.purple,
//        textColor: Colors.white,
//        barBackgroundColor: Colors.blueGrey,
//      ),
//    );
//  }
//}
