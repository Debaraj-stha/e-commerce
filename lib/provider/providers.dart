import 'dart:convert';

import 'package:e_commerce/controller/dbController.dart';
import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/pages/accountPage.dart';
import 'package:e_commerce/pages/categoryItemPage.dart';
import 'package:e_commerce/pages/homepage.dart';
import 'package:e_commerce/pages/message.dart';
import 'package:e_commerce/pages/orderProcess.dart';
import 'package:e_commerce/utils/message.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../../utils/mediumText.dart';
import 'package:e_commerce/pages/message.dart';

class e_commerceProvider with ChangeNotifier {
  TextEditingController controller = new TextEditingController();

  String baseURL = "http://10.0.2.2:8000";
  List<productCategory> _productCategories = [];
  List<productCategory> get productCategories => _productCategories;
  List<categoryItem> _categoryItems = [];
  List<categoryItem> get categoryItems => _categoryItems;
  List<Product> _product = [];
  List<Product> get product => _product;
  List<Cart> _cartItems = [];
  List<Cart> get cart => _cartItems;
  List<categoryItem> _lowPriceProduct = [];
  List<categoryItem> get lowPriceProduct => _lowPriceProduct;
  bool isQuestionShow = false;
  bool isReviewShow = false;
  int selectedCategory = 0;
  String selectedCategoryNmae = "";
  List subCategory = [];
  int selectedItemColor = 0;
  int selectedSize = 0;
  int quantity = 1;
  List<bool> isDisableButton = [false, true];
  // Map<String, Map<String, bool>> setSelectedShopProductChecked = {};
  Map<String, bool> checkBoxState = {};
  int checkedProductLength = 0;
  Map<String, bool> selectedProductChecked = {};
  Map<String, List<String>> productList = {};
  List<categoryItem> _freeDelivery = [];
  List<categoryItem> get freeDelivery => _freeDelivery;
  bool allSelected = false;
  List<bool> isfilterSelected = [false, false, false, false, false];
  String userId = "64aff915fccc11dca953d950";
  int? selectedFilterIndex;
  List<userActivity> myActivity = [];
  int deliveryCharge = 1;
  int totalProductCost = 1;
  // List<List<String>> userActivity = [];
  List<String> usercativitycategoryItems = [];
  List<String> userActivitysubcategoryItems = [];
  List<List<String>> userActivitytagsItems = [];
  List<categoryItem> _recomondedProduct = [];
  List<categoryItem> get recomondedProduct => _recomondedProduct;
  List<categoryItem> _discoveredProduct = [];
  List<categoryItem> get discoveredProduct => _discoveredProduct;
  List<Cart> purchaseList = [];
  List<Cart> cancellation = [];
  List<Order> orderList = [];
  int purchaseLength = 0;
  dbController? _dbController;
  constraunts? myConstraints;
  List<String> myLocation = [];
  List<Message> myMessage = [];
  List<User> myUser = [];
  List<categoryItem> forYouProduct = [];
  List<userMessage> yourMessage = [];
  List<Order> purchasedProduct = [];
  List<Order> toReceiveProduct = [];
  int orderLength = 0;
  List<myReview> myReviews = [];
  initialize() {
    _dbController = dbController();
  }

  Future fetchProductCategories() async {
    final response = await http.get(Uri.parse(baseURL + "/category"));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        _productCategories.add(productCategory.fromJson(item));
      }
    } else {
      message(data, true);
    }
    notifyListeners();
  }

  Future fetchCategoryItem(String category) async {
    _categoryItems = [];
    subCategory = [];
    final response = await http
        .get(Uri.parse(baseURL + "/category/product?category=${category}"));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        _categoryItems.add(categoryItem.fromJson(item));
      }
    } else {
      message(data, true);
    }
    selectedCategoryNmae = setCategoryTitle(category);
    selectedCategory =
        _categoryItems.indexWhere((element) => element.category == "makeup");
    message(selectedCategory.toString(), false);
    findSubCategory();
    notifyListeners();
  }

  Future fetchAllProduct(String priceAsc, String soldAsc) async {
    _lowPriceProduct = [];
    final response = await http.get(Uri.parse(
        baseURL + "/category/product/sort?price=priceAsc&sold=soldAsc"));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        _lowPriceProduct.add(categoryItem.fromJson(item));
      }
    } else {
      message(data, true);
    }

    findSubCategory();
    notifyListeners();
  }

  Future fetchProduct(String id) async {
    _product = [];
    final response =
        await http.get(Uri.parse(baseURL + "/product?productId=${id}"));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        _product.add(Product.fromJson(item));
      }
    } else {
      message(data, true);
    }
    notifyListeners();
  }

  findSubCategory() {
    for (int i = 0; i < _categoryItems.length; i++) {
      if (subCategory.contains(_categoryItems[i].subCategory)) {
      } else {
        subCategory.add(_categoryItems[i].subCategory);
      }
    }

    notifyListeners();
  }

  customDispose() {
    controller.dispose();
  }

  toggleReview() {
    isReviewShow = !isReviewShow;
    notifyListeners();
  }

  toggleQuestion() {
    isQuestionShow = !isQuestionShow;
    notifyListeners();
  }

  setSelectedCategory(int index) {
    selectedCategory = index;

    notifyListeners();
  }

  handlePopUpMenu(String value, BuildContext context) {
    message(value, true);
    switch (value) {
      case 'home':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePage()));
        break;
      case 'message':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => myMessagePage()));
        break;
      case 'myaccount':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => accountPage()));
        break;
    }
  }

  setCategoryTitle(String value) {
    return value;
  }

  handleCustomRadioButton(int index, bool isColor) {
    if (isColor) {
      selectedItemColor = index;
    } else {
      selectedSize = index;
    }

    notifyListeners();
  }

  void handleQuantityCount(
      bool isIncrement, int oldValue, BuildContext context) {
    if (oldValue == 1 && !isIncrement) {
      quantity = oldValue;
      showAlertMessage(context, "Quantity can not be reduced to less than 1",
          Colors.red, true);
    } else if (quantity >= 5 && isIncrement) {
      quantity = oldValue;
      showAlertMessage(
          context,
          "You cannot add more than 5 pieces of the same item",
          Colors.red,
          true);
    } else {
      if (isIncrement) {
        quantity = oldValue + 1;
      } else {
        quantity = oldValue - 1;
      }
    }

    notifyListeners();
  }

  disableButton(int quantity) {
    if (quantity == 1) {
      isDisableButton[0] = false;
      isDisableButton[1] = true;
    } else if (quantity >= 5) {
      isDisableButton[0] = true;
      isDisableButton[1] = false;
    } else {}
    notifyListeners();
  }

  showAlertMessage(BuildContext context, String text, Color color, isWarning) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: mediumText(
                  text: isWarning ? "Warning" : "succcess", color: color),
              content: smallText(text: text),
              actions: [
                TextButton(
                    style:
                        ElevatedButton.styleFrom(primary: constraunts.primary),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: smallText(
                      text: "Ok",
                      color: Colors.white,
                    ))
              ],
            ));
  }

  addToCart(
      String name,
      String image,
      String shopId,
      String productId,
      int perItem,
      int deliveryCharge,
      String color,
      String varient,
      String shopName,
      {String brand = "no brand"}) {
    _dbController!
        .insert(Cart(
            deliveryCharge: deliveryCharge,
            name: name,
            image: image,
            shopId: shopId,
            quantity: quantity,
            perItem: perItem,
            color: color,
            varient: varient,
            brand: brand,
            productId: productId,
            shopName: shopName))
        .then((value) {
      message("Item aded succesfully!!}", true);
    }).onError((error, stackTrace) {
      message("Item does not added to cart.\n Message:${error}", false);
    });
    notifyListeners();
  }

  Future<List<Cart>> loadCartData() async {
    try {
      _cartItems = await _dbController!.getList();

      message("load called", true);
      notifyListeners();
      return _cartItems;
    } catch (error) {
      message("Error loading cart data", true);
      throw error;
    }
  }

  List<GroupedCartItems> groupCartItems(List<Cart> cartItems) {
    final groupedItems = <GroupedCartItems>[];
    final shopIds = <String>[];

    for (final cartItem in cartItems) {
      if (!shopIds.contains(cartItem.shopId)) {
        shopIds.add(cartItem.shopId);

        groupedItems
            .add(GroupedCartItems(shopId: cartItem.shopId, items: [cartItem]));
      } else {
        final index =
            groupedItems.indexWhere((group) => group.shopId == cartItem.shopId);
        groupedItems[index].items.add(cartItem);
      }
    }
    // notifyListeners();
    return groupedItems;
  }

  bool isChecked(String shopIId) => checkBoxState[shopIId] ?? false;

  bool getAllSelected() => allSelected;
  bool getSelectedProduct(String productId) =>
      selectedProductChecked[productId] ?? false;
  // setChecked(String shopId, bool value, List<Cart> items) {
  //   for (Cart item in items) {
  //     if (item.shopId == shopId) {
  //       selectedProductChecked[item.productId] = value;
  //       calculateProductAndDeliveryCost(value);
  //     }
  //   }
  //   // calculateProductAndDeliveryCost(value);
  //   checkBoxState[shopId] = value;
  //   notifyListeners();
  // }
  setChecked(String shopId, bool value, List<Cart> items) {
    for (Cart item in items) {
      if (item.shopId == shopId) {
        if (productList.containsKey(item.shopId)) {
          productList[item.shopId]!.add(item.productId);
        } else {
          productList[item.shopId] = [item.productId];
        }
        selectedProductChecked[item.productId] = value;
      }
    }

    calculateProductAndDeliveryCost(value);
    checkBoxState[shopId] = value;
    setCheckedProductLength(value);
    notifyListeners();
  }

  void setProductChecked(
      bool value, String productId, String shopId, List<Cart> items) {
    selectedProductChecked[productId] = value;

    // Clear the productList entry for the current shopId
    productList[shopId] = [];

    for (Cart item in items) {
      // Add the productId of the checked item to the productList for the current shopId
      if (selectedProductChecked[item.productId] == true) {
        productList[shopId]!.add(item.productId);
      }
    }

    bool allProductsSelected = productList[shopId]?.length == items.length;

    checkBoxState[shopId] = allProductsSelected;
    calculateProductAndDeliveryCost(allProductsSelected);
    setCheckedProductLength(value);

    debugPrint(productList.toString());
    notifyListeners();
  }

  allChecked(bool value) {
    List<Cart> items = _cartItems;
    calculateProductAndDeliveryCost(value);
    for (Cart item in items) {
      selectedProductChecked[item.productId] = value;
      checkBoxState[item.shopId] = value;
    }
    allSelected = value;
    setCheckedProductLength(value);
    notifyListeners();
  }

  deleteCartItem(BuildContext context) async {
    try {
      final checkedProduct = selectedProductChecked.keys.toList();
      final isSelectedProductEmpty = selectedProductChecked.isEmpty;
      List<String> deletedCartItem = [];
      if (!isSelectedProductEmpty) {
        for (var id in checkedProduct) {
          deletedCartItem.add(id);
          await _dbController!.delete(id);
        }
        _cartItems.removeWhere(
            (element) => deletedCartItem.contains(element.productId));
        showAlertMessage(
            context, "Cart item deleted successfully", Colors.green, false);
      } else {
        showAlertMessage(
            context, "Please check first cart item", Colors.red, true);
      }
    } catch (error) {
      showAlertMessage(context, error.toString(), Colors.red, true);
    }
  }

  calculateProductAndDeliveryCost(bool value) {
    final checkedProduct = selectedProductChecked.keys.toList();

    Iterable<Cart> checkedProductList = <Cart>[];
    for (var id in checkedProduct) {
      checkedProductList =
          _cartItems.where((element) => element.productId == id);
    }

    for (Cart item in checkedProductList) {
      if (selectedProductChecked[item.productId] == true) {
        deliveryCharge = deliveryCharge + item.deliveryCharge;
        int costOfEachTypeProduct = item.perItem * item.quantity;
        totalProductCost = totalProductCost + costOfEachTypeProduct;
      } else {
        deliveryCharge = deliveryCharge - 10;
        int costOfEachTypeProduct = item.perItem * item.quantity;
        totalProductCost = totalProductCost - costOfEachTypeProduct;
      }
    }
    notifyListeners();
  }

  updateDatabase() async {
    try {
      await _dbController!.updateDatabase();
      message("success", true);
    } catch (e) {
      message("fail", false);
    }
  }

  setCheckedProductLength(bool value) {
    checkedProductLength = countCheckedProducts();

    notifyListeners();
  }

  int countCheckedProducts() {
    int checkedCount =
        selectedProductChecked.values.where((value) => value == true).length;
    return checkedCount;
  }

  validateOrder(BuildContext context) {
    if (countCheckedProducts() > 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => orderPerocess()));
    } else {
      message("Please select item(s) first", false);
    }
  }

  filterFreeDelivery(int index, String filterType, String category,
      {order = ''}) async {
//   _freeDelivery = _categoryItems.where((element) => element.deliveryCharge == 0).toList();
//   debugPrint(_freeDelivery.toString());
//   if(filterType=="freeDelivery") {
//       _freeDelivery = _categoryItems.where((element) => element.deliveryCharge == 0).toList();
//   }
//  else
// fetchAllProduct(priceAsc, soldAsc)
    _lowPriceProduct = [];
    debugPrint(order);

    final response = await http.get(Uri.parse(baseURL +
        '/category/product/sort?category=${category}&${filterType}=${order}'));

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        _lowPriceProduct.add(categoryItem.fromJson(item));
      }
    }
    for (int i = 0; i < isfilterSelected.length; i++) {
      if (i == index) {
        isfilterSelected[i] = !isfilterSelected[index];
      } else {
        isfilterSelected[i] = false;
      }
    }
    selectedFilterIndex = index;
    debugPrint(selectedFilterIndex.toString());
    notifyListeners();
  }

  List<GroupedCartItems> getCheckedCartItem() {
    final groupedItems = <GroupedCartItems>[];
    final shopIds = <String>[];

    for (final cartItem in _cartItems) {
      if (selectedProductChecked[cartItem.productId] == true) {
        if (!shopIds.contains(cartItem.shopId)) {
          shopIds.add(cartItem.shopId);

          groupedItems.add(
              GroupedCartItems(shopId: cartItem.shopId, items: [cartItem]));
        } else {
          final index = groupedItems
              .indexWhere((group) => group.shopId == cartItem.shopId);
          groupedItems[index].items.add(cartItem);
        }
      }
    }
    // notifyListeners();
    return groupedItems;
  }

  orderProduct(BuildContext context) async {
    String userId = "64b1263ec8f0dd89ce567f4f";
    final List<Map<String, dynamic>> formattedData = productList.entries
        .map((entry) => {
              entry.key: List<String>.from(entry.value),
            })
        .toList();
    debugPrint(productList.toString());
    List<Cart> checked = getCheckedCartItems(_cartItems);

    if (countCheckedProducts() > 0) {
      String deliverAddress = "";
      final response =
          await http.post(Uri.parse(baseURL + "/product/order"), body: {
        "deliveryAddress": deliverAddress,
        "userId": userId,
        "data": jsonEncode(formattedData),
      });

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var i = 0; i < checked.length; i++) {
          debugPrint(checked[i].name);

          ordersProduct(
              DateTime.now().toString(),
              "pending",
              checked[i].image,
              checked[i].name,
              checked[i].quantity,
              checked[i].perItem,
              checked[i].productId,
              data['id'],
              checked[i].color,
              checked[i].shopId,
              checked[i].shopName,
              checked[i].varient);
          deleteCartItem(context);
          // ordersProduct(checked[i]., orderStatus, image, name, quantity, perItem, productId, orderId, color, shopId, shopName, varient)
        }

        showAlertMessage(
            context, "Order placed successfully", Colors.green, true);
        // ordersProduct(DateTime.now.toString(), "pending", image, name, quantity, perItem, productId);
      } else {
        showAlertMessage(
            context,
            "Some error occured\n Message:${data['message']}",
            Colors.green,
            true);
      }
    } else {
      message("Please select item(s) first", false);
    }
  }

  postProductQuestion(String shopId, String productId, String question,
      BuildContext context) async {
    final response = await http.post(Uri.parse(baseURL + 'product/question'),
        body: {
          "userId": userId,
          "productId": productId,
          "shopId": shopId,
          "question": question
        });
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      showAlertMessage(
          context,
          "Question about product has been post successfully",
          Colors.green,
          false);
    } else {
      showAlertMessage(
          context,
          "Some error occur.\nMessage:${result['message']}",
          Colors.green,
          false);
    }
  }

  pottProductReview(
      BuildContext context, String productId, String review, int rating) async {
    final response = await http.post(Uri.parse(baseURL + 'product/review'),
        body: {
          "userId": userId,
          "productId": productId,
          "review": review,
          "rating": rating
        });
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      showAlertMessage(
          context,
          "Review about product has been post successfully.\nThankyou four your feedback.\n We will greatly think about your feedback",
          Colors.green,
          false);
    } else {
      showAlertMessage(
          context,
          "Some error occur.\nMessage:${result['message']}",
          Colors.green,
          false);
    }
  }

  int getCartItemLength() {
    int cartItemLength = _cartItems.length;

    return cartItemLength;
  }

  String convertToAgo(DateTime d) {
    Duration date = DateTime.now().difference(d);
    if (date.inDays >= 1) {
      return "${date.inDays}".toString();
    } else if (date.inMinutes >= 1) {
      return "${date.inDays}".toString();
    } else if (date.inHours >= 1) {
      return "${date.inHours}".toString();
    } else {
      return "${date.inSeconds}".toString();
    }
  }

  String convertToNumber(int num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)}K".toString();
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)}K".toString();
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)}M".toString();
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)}B".toString();
    } else {
      return "${num.toString()}";
    }
  }

  storeUserActivity(userActivity a) async {
    try {
      initialize();
      await _dbController!
          .insertUserActivity(a)
          .then((val) => {debugPrint(val.item.toString())});
      message("success", true);
    } catch (e) {
      message("error:$e", false);
    }
  }

  void getuserActivity() async {
    try {
      initialize();
      myActivity = await _dbController!.getUserActivity();

      message("success", true);

      myActivity.forEach((val) {
        debugPrint(val.item.toString());
        Map<String, dynamic>? itemMap;

        // Check if val.item is a string and starts with '{' (indicating potential JSON data)
        if (val.item is String && val.item.startsWith('{')) {
          try {
            itemMap = json.decode(val.item);
          } catch (e) {
            debugPrint("Error decoding val.item: $e");
          }

          if (itemMap is Map) {
            if (itemMap!.containsKey('category')) {
              String categoryValue = itemMap['category'];
              usercativitycategoryItems.add(categoryValue);
            }

            if (itemMap!.containsKey('subCategory')) {
              String subcategoryValue = itemMap['subCategory'];
              userActivitysubcategoryItems.add(subcategoryValue);
            }

            if (itemMap!.containsKey('tag') &&
                itemMap['tag'] is List<dynamic>) {
              List<dynamic> tagsList = itemMap['tag'];
              List<String> tagsValues =
                  tagsList.map((tag) => tag.toString()).toList();
              userActivitytagsItems.add(tagsValues);
            }
          } else {
            // Handle non-JSON data here (if needed)
            usercativitycategoryItems.add(val.item);
          }
        } else {
          // Handle non-JSON data here (if needed)
          usercativitycategoryItems.add(val.item);
        }
      });

      // ... rest of the code ...
      getRecomondation();
      notifyListeners();
    } catch (e) {
      message("error:$e", false);
      debugPrint(e.toString());
    }
  }

  getRecomondation() async {
    _recomondedProduct = [];
    String url = baseURL + '/product/recomondation';
    debugPrint("called");

    try {
      final categoryQuery = 'category=${usercativitycategoryItems.join(',')}';
      final subcategoryQuery =
          'subcategory=${userActivitysubcategoryItems.join(',')}';

      final tagsQuery =
          'tags=${userActivitytagsItems.map((list) => '[${list.join(',')}]').join(',')}';

      final completeUrl = '$url?$categoryQuery&$subcategoryQuery&$tagsQuery';
      debugPrint(completeUrl);
      final response = await http.get(Uri.parse(completeUrl));
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          _recomondedProduct.add(categoryItem.fromJson(item));
        }
        debugPrint("called");
        message("success", true);
      } else {
        message(
            "some error has occurres while fetching data.\nMessage:${data['message']}",
            true);
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getDiscoverProduct() async {
    final response = await http.get(Uri.parse(baseURL + "/product/discover"));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        _discoveredProduct.add(categoryItem.fromJson(item));
      }
    } else {
      message(data, true);
    }
    notifyListeners();
  }

  // purchaseProduct(Cart cart) async {
  //   initialize();
  //   try {
  //     _dbController!.insertPurchase(cart).then((value) {
  //       debugPrint("success");
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  getPurchaseList() async {
    try {
      initialize();
      // purchaseList = await _dbController!.getPurchaseList();
      List<Cart> orders = await _dbController!.getPurchaseList();
      // await getOrdersList();
      debugPrint("calldd purchase");
      for (var item in orders) {
        for (var data in orderList) {
          debugPrint(data.status);
          if (data.status != "cancelled") {
            purchaseList.add(item);
          }
        }
      }
      getPurchaseLength();
      notifyListeners();
    } catch (e) {}
  }

  getPurchaseLength() {
    purchaseLength = purchasedProduct.length;
    notifyListeners();
  }

  getOrderLength() {
    orderLength = toReceiveProduct.length;
    notifyListeners();
  }

  Future<void> getLocation() async {
    Location location = Location();
    bool isEnabled;
    PermissionStatus permissionStatus;
    LocationData locationData;
    isEnabled = await location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await location.requestService();
    }
    if (!isEnabled) {
      return;
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    constraunts.lat = locationData.latitude!;
    constraunts.long = locationData.longitude!;
    myConstraints = constraunts();
    myConstraints!
        .getLocationData(locationData.latitude!, locationData.longitude!)
        .then((value) {
      myLocation.add(value[0].country);
      myLocation.add(value[0].street);
    });
    debugPrint(locationData.toString());
    notifyListeners();
  }

  insertCancelOrder(Cart cart) async {
    initialize();
    try {
      _dbController!.insertCancellation(cart).then((value) {
        debugPrint("success");
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getCancelPurchase() async {
    initialize();
    cancellation = await _dbController!.getCancelProduct();
    debugPrint("success");
    notifyListeners();
  }

  Future<void> ordersProduct(
      String orderAt,
      String orderStatus,
      String image,
      String name,
      int quantity,
      int perItem,
      String productId,
      String orderId,
      String color,
      String shopId,
      String shopName,
      String varient) async {
    try {
      initialize();

      await _dbController!.insertOrder(Order(
          name: name,
          image: image,
          color: color,
          shopId: shopId,
          quantity: quantity,
          perItem: perItem,
          productId: productId,
          deliveryCharge: deliveryCharge,
          shopName: shopName,
          orderId: orderId,
          orderAt: orderAt,
          varient: varient));

      debugPrint("success");
    } catch (e) {
      debugPrint("Error inserting order: $e");
    }
  }

  getOrdersList() async {
    try {
      orderList = [];
      purchasedProduct = [];
      orderList = await _dbController!.getOrders();

      for (var data in orderList) {
        if (data.status == "delivered") {
          purchasedProduct.add(data);
        }
      }
      getPurchaseLength();
      notifyListeners();
    } catch (e) {}
  }

  getToReceiveList() async {
    try {
      orderList = [];
      toReceiveProduct = [];
      orderList = await _dbController!.getOrders();

      for (var data in orderList) {
        if (data.status != "delivered") {
          toReceiveProduct.add(data);
        }
      }
      getOrderLength();
      notifyListeners();
    } catch (e) {}
  }

  getMessage() async {
    final response = await http.get(Uri.parse(baseURL + "/message"));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        myMessage.add(Message.fromJson(item));
      }
    } else {
      message(data, true);
    }
    notifyListeners();
  }

  insertUser(User user) async {
    try {
      initialize();
      _dbController!.insertUser(user).then((val) {
        message(val.toString(), true);
      });
    } catch (e) {
      message(e.toString(), false);
    }
  }

  getUser() async {
    try {
      initialize();
      myUser = await _dbController!.getUser();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateUser(
      String id, String name, String deliverAddress, String phone) async {
    try {
      await _dbController!
          .updateUser(
              User(
                  id: id,
                  name: name,
                  deliveryAddress: deliverAddress,
                  phone: phone),
              id)
          .then((value) {
        message(value.deliveryAddress.toString(), true);
      });
    } catch (e) { 
      debugPrint(e.toString());
    }
  }

  void sendSMSTo(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      debugPrint(onError.toString());
    });
    debugPrint(_result);
  }

  void login(String name, String phone, String password, String email,
      String image) async {
    final response = await http.post(Uri.parse(baseURL + "/login"), body: {
      "name": name,
      "phone": phone,
      "email": email,
      "image": image,
      "password": password
    });
// _sendSMS("testing demo message", ['+9779819336010']);
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      insertUser(User.fromJson(data['data']));
    } else {
      message("Error has occured  ${data['message']}", false);
    }
  }

  void searchProduct() async {
    try {
      _categoryItems = [];
      final response = await http
          .get(Uri.parse(baseURL + "/product/search?q=${controller.text}"));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          _categoryItems.add(categoryItem.fromJson(item));
        }
        notifyListeners();
      } else {
        message(data['message'], false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getForYouProduct() async {
    try {
      
      final response = await http.get(Uri.parse(baseURL + "/product/for-you"));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data) {
          forYouProduct.add(categoryItem.fromJson(item));
        }
        notifyListeners();
      } else {
        message(data['message'], false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<Cart> getCheckedCartItems(List<Cart> items) {
    List<Cart> checkedItems = [];

    for (Cart item in items) {
      if (selectedProductChecked[item.productId] == true) {
        checkedItems.add(item);
      }
    }

    return checkedItems;
  }

  sendMessageToShop(String shopId, String m) async {
    await getUser();
    final String userId = myUser[0].id!;
    final response = await http.post(Uri.parse(baseURL + '/message-to/shop'),
        body: {"userId": userId, "shopId": shopId, "message": m});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      message("message sent successfully", true);
      getUserMessage(shopId);
    } else {
      message(data['message'], false);
    }
    notifyListeners();
  }

  getUserMessage(String shopId) async {
    await getUser();
    yourMessage = [];
    final String userId = myUser[0].id!;
    final response = await http.get(Uri.parse(
        baseURL + '/message-to/shop?shopId=${shopId}&userId=${userId}'));
    debugPrint(baseURL + '/message-to/shop?shopId=${shopId}&userId=${userId}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data) {
        yourMessage.add(userMessage.fromJson(item));
      }
      message("message load successfully", true);
    } else {
      message(data['message'], false);
    }

    notifyListeners();
  }

  void cancelOrder(
      Order model, String id, Cart cart, BuildContext context) async {
    try {
      initialize();
      await _dbController!.updateOrder(model, id);
      await insertCancelOrder(cart);

      updateOrder();
      getOrdersList();
      notifyListeners();
      showAlertMessage(
          context, "Oredr cancelled successfully", Colors.green, false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateOrder() async {
    String userId = "64b1263ec8f0dd89ce567f4f";
    final response =
        await http.get(Uri.parse(baseURL + '/get-order?userId=${userId}'));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      initialize();
      for (var item in data) {
        for (var order in orderList) {
          if (item['_id'] == order.orderId) {
            Order myOrder = Order(
                name: order.name,
                image: order.image,
                color: order.color,
                quantity: order.quantity,
                perItem: order.perItem,
                productId: order.productId,
                deliveryCharge: order.deliveryCharge,
                shopName: order.shopName,
                orderId: order.orderId,
                orderAt: order.orderAt,
                varient: order.varient,
                status: item['orderStatus']);
            _dbController!.updateOrder(myOrder, order.orderId);
          }
        }
      }

      notifyListeners();
    }
  }

  insertMyReview(myReview review) async {
    try {
      initialize();
      await _dbController!
          .insertReview(review)
          .then((value) => {debugPrint(value.review)});
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  loadMyReview() async {
    try {
      initialize();
      myReviews = await _dbController!.getReview();
      debugPrint(myReviews.toString());
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
