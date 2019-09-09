import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:saveat/data/appData.dart';
import 'package:saveat/model/Cart.dart';
import 'package:saveat/model/Category.dart';
import 'package:saveat/model/Favourite.dart';
import 'package:saveat/model/Product.dart';
import 'package:saveat/routes/route.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:saveat/widgets/myToast.dart';

class MyScopedModel extends Model {
  //list of app components
  List<Product> _product = [];
  List<Product> _productDetailList = [];

  List<Cart> _cart = [];
  List<Favourite> _favourites = [];
  List<Category> _category = [];

//product detail data
  var _productDetail;

  //user detail data
  var _userDetail;

  var _favouriteSingleProduct;

//bool method to show progress while loading data
  bool _isLoading = false;

//get methods to get data

  List<Product> get products {
    return _product;
  }

  get productDetail {
    return _productDetail;
  }

  get userDetail {
    return _userDetail;
  }

  get favouriteSingleProduct {
    return _favouriteSingleProduct;
  }

  List<Product> get productDetailList {
    return _productDetailList;
  }

  List<Category> get categories {
    return _category;
  }

  int productLength() {
    return _product.length;
  }

  List<Cart> get cart {
    return _cart;
  }

  List<Favourite> get favourites {
    return _favourites;
  }

  bool get isLoading {
    return _isLoading;
  }

//fetch products methods
  void fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseProducts = await http.get(AppData.URl + 'products');
      if (responseProducts.statusCode == 200 ||
          responseProducts.statusCode == 201) {
        final List<Product> fetchedProductList = [];
        List<dynamic> responseProductData =
            jsonDecode(responseProducts.body)['products'];
        responseProductData?.forEach((dynamic productData) {
          final Product product = Product(
              productData['_id'],
              productData['name'],
              productData['slug'],
              productData['description'],
              productData['price'],
              productData['discount'],
              productData['bestBuyDate'],
              productData['vendorID'],
              productData['productImage'],
              productData['category']);
          fetchedProductList.add(product);
        });
        _product = fetchedProductList;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch productDetail(Single product)
  void fetchProductDetail(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseProductDetail = await http
          .get(AppData.URl + 'product/' + id); //"5d5c22ae10e29202e98523ff"
      if (responseProductDetail.statusCode == 200 ||
          responseProductDetail.statusCode == 201) {
        var responseProductDetailData =
            jsonDecode(responseProductDetail.body)['product'];
        _productDetail = responseProductDetailData;
        fetchUserDetail(responseProductDetailData['vendorID']);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch productByCategory
  void fetchProductByCategory(String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseProductByCat =
          await http.get(AppData.URl + 'product/category/' + category);
      if (responseProductByCat.statusCode == 200 ||
          responseProductByCat.statusCode == 201) {
        final List<Product> fetchedProductList = [];
        List<dynamic> responseProductData =
            jsonDecode(responseProductByCat.body)['product'];
        responseProductData?.forEach((dynamic productData) {
          final Product product = Product(
              productData['_id'],
              productData['name'],
              productData['slug'],
              productData['description'],
              productData['price'],
              productData['discount'],
              productData['bestBuyDate'],
              productData['vendorID'],
              productData['category'],
              productData['productImage']);

          fetchedProductList.add(product);
        });
        _product = fetchedProductList;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch Category
  void fetchCategory() async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http.get(AppData.URl + 'API-categories');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Category> fetchedCategoryList = [];
        List<dynamic> responseData = jsonDecode(response.body)['category'];
        responseData?.forEach((dynamic categoryData) {
          final Category category =
              Category(categoryData['name'], categoryData['categoryImage']);
          fetchedCategoryList.add(category);
        });
        _category = fetchedCategoryList;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch cart items
  void fetchCart(uID) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseCart = await http.get(AppData.URl + 'cart/' + uID);
      if (responseCart.statusCode == 200 || responseCart.statusCode == 201) {
        final List<Cart> fetchedCartList = [];
        List<dynamic> responseCartData = jsonDecode(responseCart.body)['cart'];
        responseCartData?.forEach((dynamic cartData) {
          final Cart cart = Cart(
            cartData['quantity'] as int,
            cartData['total'] as int,
            cartData['productID'] as String,
            cartData['productName'] as String,
            cartData['productImage'] as String,
            cartData['productCategory'] as String,
            cartData['vendorID'] as String,
            cartData['vendorName'] as String,
          );
          fetchedCartList.add(cart);
        });
        _cart = fetchedCartList;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//post Cart data
  void postCartData(String uID, pID, pName, pCat, pImg, price, vendorID,
      vendorName, context) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response =
          await http.post(AppData.URl + 'cart-add/' + pID, body: {
        'userID': uID,
        'productID': pID,
        "productName": pName,
        "productImage": pImg,
        "productCategory": pCat,
        "vendorID": vendorID,
        "vendorName": vendorName,
        'quantity': "1",
        'total': price,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var respObjCart = jsonDecode(response.body);
        var resStatusCart = respObjCart['status'];
        if (resStatusCart == 1) {
          myToast(respObjCart['msg'], context);
        } else if (resStatusCart == 0) {
          myToast(respObjCart['msg'], context);
        } else {
          myToast("Something went wrong", context);
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//cart inxrease product quantity
  void postCartDataIncrease(String pID, uID, context) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http
          .post(AppData.URl + 'cart-increase/' + pID + "/" + uID, body: {
        'userID': pID,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var respObjCart = jsonDecode(response.body);
        var resStatusCart = respObjCart['status'];
        if (resStatusCart == 1) {
          myToast(respObjCart['msg'], context);
          fetchCart(uID);
        } else if (resStatusCart == 0) {
          myToast(respObjCart['msg'], context);
        } else {
          myToast("Something went wrong", context);
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//cart increase product quantity
  void postCartDataDecrease(String pID, uID, context) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http
          .post(AppData.URl + 'cart-decrease/' + pID + "/" + uID, body: {
        'userID': pID,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var respObjCart = jsonDecode(response.body);
        var resStatusCart = respObjCart['status'];
        if (resStatusCart == 1) {
          myToast(respObjCart['msg'], context);
          fetchCart(uID);
        } else if (resStatusCart == 0) {
          myToast(respObjCart['msg'], context);
        } else {
          myToast("Something went wrong", context);
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//cart checkout
  void postCartCheckout(String uID, context) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response =
          await http.post(AppData.URl + 'checkcart/' + uID, body: {
        'id': uID,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var respObjCartCheckout = jsonDecode(response.body);
        var resStatusCartcheckout = respObjCartCheckout['status'];
        if (resStatusCartcheckout == 1) {
          myToast(respObjCartCheckout['msg'], context);
          MyRoute.goToQRGenerator(context, uID);
        } else if (resStatusCartcheckout == 0) {
          myToast(respObjCartCheckout['msg'], context);
        } else {
          myToast("Something went wrong", context);
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch qr codes of products
//fetch cart items
  void fetchQRCodes(uID) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseCart =
          await http.get(AppData.URl + 'generate-cart-qr/' + uID);
      if (responseCart.statusCode == 200 || responseCart.statusCode == 201) {
        final List<Cart> fetchedCartList = [];
        List<dynamic> responseCartData = jsonDecode(responseCart.body)['data'];
        responseCartData?.forEach((dynamic cartData) {
          final Cart cart = Cart(
            cartData['quantity'] as int,
            cartData['total'] as int,
            cartData['productID'] as String,
            cartData['productName'] as String,
            cartData['productImage'] as String,
            cartData['productCategory'] as String,
            cartData['vendorID'] as String,
            cartData['vendorName'] as String,
          );
          fetchedCartList.add(cart);

          fetchUserDetail(cartData['vendorID']);
        });

        _cart = fetchedCartList;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch Favourite items
  void fetchFavourite(uID) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseFav =
          await http.get(AppData.URl + 'favourites/' + uID);
      if (responseFav.statusCode == 200 || responseFav.statusCode == 201) {
        final List<Favourite> fetchedFavtList = [];
        List<dynamic> responseFavData = jsonDecode(responseFav.body)['data'];
        responseFavData?.forEach((dynamic favData) {
          final Favourite favourite = Favourite(
            favData['userID'] as String,
            favData['productID'] as String,
            favData['productName'] as String,
            favData['productImage'] as String,
            favData['productPrice'] as String,
            favData['productDiscountPrice'] as String,
            favData['liked'] as bool,
          );

          fetchedFavtList.add(favourite);
        });
        _favourites = fetchedFavtList;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch userDetail
  void fetchfavouriteSingleProduct(uID, pID) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responsefavouriteSingleProductDetail = await http
          .get(AppData.URl + 'favourite-single-product/' + uID + "/" + pID);
      if (responsefavouriteSingleProductDetail.statusCode == 200 ||
          responsefavouriteSingleProductDetail.statusCode == 201) {
        var responsefavouriteSingleProductDetailData =
            jsonDecode(responsefavouriteSingleProductDetail.body)['data'];
        _favouriteSingleProduct = responsefavouriteSingleProductDetailData;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

// post favourite
  void postFavourite(uID, pID, pName, pImg, pPrice, pDisc, context) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseFetch =
          await http.post(AppData.URl + 'favourite-add', body: {
        'userID': uID,
        'productID': pID,
        "productName": pName,
        "productImage": pImg,
        "productPrice": pPrice,
        "productDiscountPrice": pDisc,
      });
      if (responseFetch.statusCode == 200 || responseFetch.statusCode == 201) {
        var respObjFav = jsonDecode(responseFetch.body);
        var resStatusFavourite = respObjFav['status'];
        if (resStatusFavourite == 1) {
          myToast(respObjFav['msg'], context);
        } else if (resStatusFavourite == 0) {
          myToast(respObjFav['msg'], context);
        } else {
          myToast("Something went wrong", context);
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//fetch userDetail
  void fetchUserDetail(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseUserDetail =
          await http.get(AppData.URl + 'users/profile/' + id);
      if (responseUserDetail.statusCode == 200 ||
          responseUserDetail.statusCode == 201) {
        print(responseUserDetail.body);
        var responseUserDetailData =
            jsonDecode(responseUserDetail.body)['user'];
        _userDetail = responseUserDetailData;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

  /// *
  /// vendor Scoped model start from here
  //post product
  void postProduct(String pName, pDesc, pPrice, pDisc, pBestBD, pCat, pVendor,
      File pImage, context) async {
    _isLoading = true;
    notifyListeners();

    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(pImage.openRead()));
    // get file length
    var length = await pImage.length();
    // string to uri
    var uri = Uri.parse(AppData.URl + 'product-add');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(pImage.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    // Dio dio = new Dio();
    // FormData formData = new FormData.from({
    //   'name': pName,
    //   'description': pDesc,
    //   "price": pPrice,
    //   "discount": pDisc,
    //   "bestBuyDate": pBestBD,
    //   'category': pCat,
    //   'vendorID': pVendor,
    //   "productImage": new UploadFileInfo(pImage, basename(pImage.path),
    //       contentType: ContentType("contentType", "multipart/form-data"))
    // });
    // dio
    //     .post(AppData.URl + 'product-add',
    //         data: formData,
    //         options: Options(
    //           headers: {
    //             "Content-Type": "multipart/form-data",
    //           },
    //           method: 'POST',
    //           responseType: ResponseType.json, // or ResponseType.JSON
    //         ))
    //     .then((response) => print(response))
    //     .catchError((error) => print(error));

//create multipart request for POST or PATCH method
    // var stream = new http.ByteStream(DelegatingStream.typed(pImage.openRead()));
    // var length = await pImage.length();

    // var request =
    //     http.MultipartRequest("POST", Uri.parse(AppData.URl + 'product-add'));
    // //add text fields
    // request.fields["name"] = pName;
    // request.fields["description"] = pDesc;
    // request.fields["price"] = pPrice;
    // request.fields["discount"] = pDisc;
    // request.fields["bestBuyDate"] = pBestBD;
    // request.fields["category"] = pCat;
    // request.fields["vendorID"] = pVendor;
    // //create multipart using filepath, string or bytes
    // var pic = new http.MultipartFile('productImage', stream, length,
    //     filename: basename(pImage.path));

    // //add multipart to request
    // request.files.add(pic);
    // var response = await request.send();

    // //Get the response from the server
    // if (response.statusCode == 200) {
    //   myToast("Image Uploaded", context);
    // } else {
    //   myToast("Upload Failed", context);
    // }
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });

    // http.Response responseProduct = await http.post(AppData.URl + 'product-add',
    //     body: {
    //       'name': pName,
    //       'description': pDesc,
    //       "price": pPrice,
    //       "discount": pDisc,
    //       "bestBuyDate": pBestBD,
    //       'category': pCat,
    //       'vendorID': pVendor,
    //       "productImage": pImage
    //     },

    //     encoding: Encoding.getByName("utf-8"));
    // if (responseProduct.statusCode == 200 ||
    //     responseProduct.statusCode == 201) {
    //   var respObjProduct = jsonDecode(responseProduct.body);
    //   myToast(responseProduct.body, context);
    // }
    //   var resStatusProduct = respObjProduct['status'];
    //   if (resStatusProduct == 1) {
    //     myToast(respObjProduct['msg'], context);
    //     MyRoute.goToVendorHome(context);
    //   } else if (resStatusProduct == 0) {
    //     myToast(respObjProduct['msg'], context);
    //   } else {
    //     myToast("Something went wrong", context);
    //   }
    // }
    //   _isLoading = false;
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }

//fetch productByVendorID
  void fetchProductByVendorID(String vendorID) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseProductByVID =
          await http.get(AppData.URl + 'product/vendor/' + vendorID);
      if (responseProductByVID.statusCode == 200 ||
          responseProductByVID.statusCode == 201) {
        final List<Product> fetchedProductList = [];
        List<dynamic> responseProductData =
            jsonDecode(responseProductByVID.body)['product'];
        print(responseProductByVID.body);
        responseProductData?.forEach((dynamic productData) {
          final Product product = Product(
              productData['_id'],
              productData['name'],
              productData['slug'],
              productData['description'],
              productData['price'],
              productData['discount'],
              productData['bestBuyDate'],
              productData['vendorID'],
              productData['category'],
              productData['productImage']);

          fetchedProductList.add(product);
        });
        _product = fetchedProductList;
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }

//datele product
//fetch productByVendorID
  void deleteProduct(String pID, context) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response responseDelete =
          await http.get(AppData.URl + 'product-delete/' + pID);
      if (responseDelete.statusCode == 200 ||
          responseDelete.statusCode == 201) {
        var respObjDelete = jsonDecode(responseDelete.body);
        print(responseDelete.body);
        var resStatusDelete = respObjDelete['status'];
        if (resStatusDelete == 1) {
          myToast(respObjDelete['msg'], context);
        } else if (resStatusDelete == 0) {
          myToast(respObjDelete['msg'], context);
          _isLoading = false;
          notifyListeners();
        } else {
          myToast("Something went wrong", context);
          _isLoading = false;
          notifyListeners();
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
    }
  }
}
