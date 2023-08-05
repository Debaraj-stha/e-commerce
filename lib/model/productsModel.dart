import 'dart:convert';

class User {
  User(
      {this.id,
      required this.name,
      this.image,
      this.phone,
      this.deliveryAddress,
      this.email});
  String? id;
  String name;
  String? image;
  String? phone;
  String? email;
  String? deliveryAddress;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      phone: json["phone"],
      email: json["email"],
      deliveryAddress: json["deliveryAddress"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "image": image,
      "phone": phone,
      "deliveryAddress": deliveryAddress
    };
  }
}

class productCategory {
  productCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
  });

  String id;
  String name;
  String category;
  String image;

  factory productCategory.fromJson(Map<String, dynamic> json) =>
      productCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "category": category,
      };
}

class userActivity {
  userActivity({required this.id, required this.item});
  int id;
  String item;

  Map<String, dynamic> toJson() => {"id": id, "item": item};

  factory userActivity.fromJson(Map<String, dynamic> data) =>
      userActivity(id: data['id'], item: data['item']);

  factory userActivity.fromJSONString(String jsonString) =>
      userActivity.fromJson(json.decode(jsonString));

  static String nestedListToJSONString(List<Map<String, dynamic>> nestedList) =>
      json.encode(nestedList);

  static List<Map<String, dynamic>> nestedListFromJSONString(
          String jsonString) =>
      List<Map<String, dynamic>>.from(json.decode(jsonString));
}

class categoryItem {
  categoryItem(
      {required this.name,
      required this.category,
      required this.subCategory,
      required this.id,
      required this.sold,
      required this.price,
      this.tag,
      required this.salesPrice,
      required this.image,
      this.deliveryCharge});

  String name;
  int? deliveryCharge;
  String subCategory;
  int price;
  int salesPrice;
  int sold;
  String category;
  String id;
  List<dynamic>? tag;
  String image;

  factory categoryItem.fromJson(Map<String, dynamic> data) => categoryItem(
      sold: data["sold"],
      name: data["name"],
      category: data["category"],
      subCategory: data["subCategory"],
      id: data["id"],
      image: data["images"],
      price: data["price"],
      salesPrice: data["salesPrice"],
      tag: data['tag'],
      deliveryCharge: data['deliveryCharge']);

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "sold": sold,
        "delieveryCharge": deliveryCharge,
        "image": image,
        "name": name,
        "category": category,
        "subCategory": subCategory,
        "price": price,
        "salesPrice": salesPrice,
        "id": id,
      };
}

class Cart {
  Cart(
      {required this.name,
      required this.image,
      required this.color,
      required this.shopId,
      required this.quantity,
      required this.perItem,
      required this.productId,
      required this.deliveryCharge,
      this.brand,
      required this.shopName,
      required this.varient});
  String name;
  String color;
  String image;
  String productId;
  String shopId;
  int quantity;
  int perItem;
  String? brand;
  String shopName;
  int deliveryCharge;

  String varient;
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      shopName: json['shopName'],
      color: json['color'],
      brand: json['brand'],
      deliveryCharge: json['deliveryCharge'],
      name: json["name"],
      image: json["image"],
      productId: json["productId"],
      shopId: json["shopId"],
      perItem: json["perItem"],
      quantity: json["quantity"],
      varient: json['varient']);

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "varient": varient,
        "deliveryCharge": deliveryCharge,
        "productId": productId,
        "shopId": shopId,
        "name": name,
        "image": image,
        "quantity": quantity,
        "perItem": perItem,
        "color": color,
        "brand": brand
      };
}

class Order {
  Order(
      {required this.name,
      required this.image,
      required this.color,
      this.shopId,
      required this.quantity,
      required this.perItem,
      required this.productId,
      required this.deliveryCharge,
      this.brand,
      required this.shopName,
      this.status,
      required this.orderId,
      required this.orderAt,
      required this.varient});
  String name;
  String color;
  String image;
  String productId;
  String? shopId;
  int quantity;
  int perItem;
  String? brand;
  String shopName;
  int deliveryCharge;
  String? status;
  String varient;
  String orderId;
  String orderAt;
  factory Order.fromJson(Map<String, dynamic> json) => Order(
      shopName: json['shopName'],
      color: json['color'],
      brand: json['brand'],
      deliveryCharge: json['deliveryCharge'],
      name: json["name"],
      image: json["image"],
      productId: json["productId"],
      shopId: json["shopId"],
      perItem: json["perItem"],
      quantity: json["quantity"],
      orderId: json['orderId'],
      status: json['status'],
      orderAt: json['orderAt'],
      varient: json['varient']);

  Map<String, dynamic> toJson() => {
        "orderAt": orderAt,
        "shopName": shopName,
        "status": status,
        "varient": varient,
        "deliveryCharge": deliveryCharge,
        "productId": productId,
        "shopId": shopId,
        "name": name,
        "image": image,
        "quantity": quantity,
        "perItem": perItem,
        "color": color,
        "brand": brand,
        "orderId": orderId,
      };
}

class ShopId {
  final String id;
  final String name;
  final String location;
  final String image;

  ShopId(
      {required this.id,
      required this.name,
      required this.location,
      required this.image});

  factory ShopId.fromJson(Map<String, dynamic> json) {
    return ShopId(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      image: json['image'],
    );
  }
}

class Review {
  final String id;
  final String review;
  final int rating;
  final String userId;
  final List<User> user;

  Review({
    required this.id,
    required this.review,
    required this.rating,
    required this.userId,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      review: json['review'],
      rating: json['rating'],
      userId: json['userId'],
      user: List<User>.from(json['user'].map((u) => User.fromJson(u))),
    );
  }
}

class QuestionAnswer {
  final String id;
  final String question;
  final String answer;
  final String questionDate;
  final String userId;
  final List<User> user;

  QuestionAnswer({
    required this.id,
    required this.question,
    required this.answer,
    required this.questionDate,
    required this.userId,
    required this.user,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
      questionDate: json['questionDate'],
      userId: json['userId'],
      user: List<User>.from(json['user'].map((u) => User.fromJson(u))),
    );
  }
}

class RecommendedProduct {
  final String id;
  final String name;
  final String images;
  final String category;
  final int salesPrice;
  final int price;
  final int sold;
  final String subCategory;

  RecommendedProduct({
    required this.id,
    required this.name,
    required this.images,
    required this.category,
    required this.salesPrice,
    required this.price,
    required this.sold,
    required this.subCategory,
  });

  factory RecommendedProduct.fromJson(Map<String, dynamic> json) {
    return RecommendedProduct(
      id: json['id'],
      name: json['name'],
      images: json['images'],
      category: json['category'],
      salesPrice: json['salesPrice'],
      price: json['price'],
      sold: json['sold'],
      subCategory: json['subCategory'],
    );
  }
}

class Product {
  final String id;
  final String name;
  final ShopId shopId;
  final int deliveryCharge;
  final String category;
  final String subCategory;
  final List<String> tag;
  final int salesPrice;
  final int price;
  final List<String> hilights;
  final String images;
  final String? brand;
  final String warranty;
  final String instock;
  final List<String>? color;
  final List<String>? variant;
  final List<Review>? reviewId;
  final List<QuestionAnswer>? questionId;
  final String description;
  final int sold;
  final List<RecommendedProduct> recommended;
  final List<RecommendedProduct> fromSameStore;

  Product({
    required this.id,
    required this.name,
    required this.shopId,
    required this.deliveryCharge,
    required this.category,
    required this.subCategory,
    required this.tag,
    required this.salesPrice,
    required this.price,
    required this.hilights,
    required this.images,
    this.brand,
    required this.warranty,
    required this.instock,
    this.color,
    this.variant,
    this.reviewId,
    this.questionId,
    required this.description,
    required this.sold,
    required this.recommended,
    required this.fromSameStore,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      shopId: ShopId.fromJson(json['shopId']),
      deliveryCharge: json['deliveryCharge'],
      category: json['category'],
      subCategory: json['subCategory'],
      tag: List<String>.from(json['tag']),
      salesPrice: json['salesPrice'],
      price: json['price'],
      hilights: List<String>.from(json['hilights']),
      images: json['images'],
      brand: json['brand'],
      warranty: json['warranty'],
      instock: json['instock'],
      color: List<String>.from(json['color']),
      variant: List<String>.from(json['varient']),
      reviewId:
          List<Review>.from(json['reviewId'].map((r) => Review.fromJson(r))),
      questionId: List<QuestionAnswer>.from(
          json['questionId'].map((qa) => QuestionAnswer.fromJson(qa))),
      description: json['description'],
      sold: json['sold'],
      recommended: List<RecommendedProduct>.from(
          json['recomonded'].map((r) => RecommendedProduct.fromJson(r))),
      fromSameStore: List<RecommendedProduct>.from(
          json['fromSameStore'].map((p) => RecommendedProduct.fromJson(p))),
    );
  }
}

class GroupedCartItems {
  final String shopId;
  final List<Cart> items;

  GroupedCartItems({
    required this.shopId,
    required this.items,
  });
}

class Message {
  String title;
  String description;
  DateTime created;
  Message(
      {required this.title, required this.description, required this.created});
  factory Message.fromJson(Map<String, dynamic> json) => Message(
      title: json['title'],
      description: json['description'],
      created: DateTime.parse(json['createdAt']));
}

class userMessage {
  userMessage(
      {required this.message,
      required this.at,
      required this.isSender,
      required this.id});
  String message;
  DateTime at;
  bool isSender;
  String id;
  factory userMessage.fromJson(Map<String, dynamic> json) => userMessage(
      at: DateTime.parse(json['at']),
      isSender: json['isSender'],
      id: json['_id'],
      message: json['message']);
}

class myReview {
  String review;
  String image;
  String productId;
  String reviewAt;
  int rating;
  myReview(
      {required this.reviewAt,
      required this.review,
      required this.image,
      required this.productId,
      required this.rating});
  factory myReview.fromJson(Map<String, dynamic> json) => myReview(
      image: json['image'],
      review: json['review'],
      productId: json['productId'],
      reviewAt: json['reviewAt'],
      rating: json['rating']);
  Map<String, dynamic> toJson() => {
        "image": image,
        "review": review,
        "productId": productId,
        "rating": rating,
        "reviewAt": reviewAt
      };
}
