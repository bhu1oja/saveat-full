import 'package:flutter/material.dart';
import 'package:saveat/UIScreens/Vendor/addnewProduct.dart';
import 'package:saveat/UIScreens/Vendor/vendorHome.dart';
import 'package:saveat/UIScreens/Vendor/vendorProducts.dart';
import 'package:saveat/UIScreens/user/cartQRGenerator.dart';
import 'package:saveat/UIScreens/user/productDetail.dart';
import 'package:saveat/UIScreens/user/productsByCategory.dart';
import 'package:saveat/UIScreens/user/tabs/cartTab.dart';
import 'package:saveat/UIScreens/user/tabs/categoryTab.dart';
import 'package:saveat/UIScreens/user/userHome.dart';
import 'package:saveat/loginStuffs/login.dart';
import 'package:saveat/loginStuffs/signup.dart';

class MyRoute {
  static void goToVendorHome(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return VendorHome();
        },
        transitionsBuilder: (context, animation1, animation2, child) {
          return FadeTransition(
            opacity: animation1,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000),
      ),
    );
  }

  static void goToUserHome(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return UserHome();
        },
        transitionsBuilder: (context, animation1, animation2, child) {
          return FadeTransition(
            opacity: animation1,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000),
      ),
    );
  }

  static void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  static void goToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  static void goToProductDetail(BuildContext context, data) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetail(data)),
    );
  }

  static void goToProductByCategory(BuildContext context, data, userID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductByCategory(data, userID)),
    );
  }

  static void goToCart(BuildContext context, userID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyCart(userID)),
    );
  }

  static void goToCategories(BuildContext context, userID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyCategoryTab(userID)),
    );
  }

  static void goToAddNewProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewProduct()),
    );
  }

  static void goToQRGenerator(BuildContext context, userID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartQRGenerator(userID)),
    );
  }

  /**
   * vendor section 
   */

  static void goToProductByVendorID(BuildContext context, vendorId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VendorProduct(vendorId)),
    );
  }

  // static void goToQRScanner(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => CameraApp()),
  //   );
  // }
}
